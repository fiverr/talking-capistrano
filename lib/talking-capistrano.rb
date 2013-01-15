require "talking-capistrano/version"
require 'JSON'

module TalkingCapistrano
  module SkypeNotification
    require 'skypemac'   

    class << self; attr_accessor :topic; end
    def self.set_notify(topic_exist)
      @notify = topic_exist
      @topic = topic_exist if topic_exist
    end
    def self.notify?
      @notify
    end

    def self.notify(text)
      chats = SkypeMac::Chat.recent_chats
      target_chat = chats.find do |chat|
        chat.topic==@topic
      end
        target_chat.send_message(pad_text text) unless target_chat.nil?
    end
    def self.pad_text(text)
      "TalkingCapistrano: #{text}"
    end
  end
end

module TalkingCapistrano
  @DATA_SET = JSON.load( File.read(File.join(File.dirname(__FILE__), '/talking-capistrano.json' )) )
  def self.say_deploy_started(rails_env ="unknown env")
     get_item(:say_deploy_started).sub!  "ENV", rails_env
  end
  def self.say_deploy_completed(rails_env ="unknown env")
     get_item(:say_deploy_completed).sub!  "ENV", rails_env
  end
  def self.say_deploy_failed(rails_env ="unknown env")
     get_item(:say_deploy_failed).sub!  "ENV", rails_env
  end
  def self.say_speaker_name
     get_item(:voices)
  end  

  private

  def self.get_item(arr)
      @DATA_SET[arr.to_s].shuffle(random: Time.now.to_i).first
  end 
end




## In a capistrano scope
Capistrano::Configuration.instance.load do

      set :speaker, TalkingCapistrano::say_speaker_name
      set :say_deploy_started, TalkingCapistrano::say_deploy_started(rails_env)
      set :say_deploy_completed, TalkingCapistrano::say_deploy_completed(rails_env)
      set :say_deploy_failed, TalkingCapistrano::say_deploy_failed(rails_env)

      set :say_command, "say"

      #Say related tasks to notify deployments to the group
      namespace :deploy do
        namespace :say do
          task :about_to_deploy do
            `#{say_command} #{say_deploy_started} -v '#{speaker}' &`
          end
        end
      end


      #Overide capistrano code deploy, to add the on error hook, seems to not be called otherwise
      namespace :deploy do
        task :update_code, :except => { :no_release => true } do
          on_rollback do
            `#{say_command} #{say_deploy_failed} -v #{speaker} &`;
              if TalkingCapistrano::SkypeNotification.notify?
                 TalkingCapistrano::SkypeNotification.notify(say_deploy_failed)
              end            
              run "rm -rf #{release_path}; true" 
          end
          strategy.deploy!
          finalize_update
        end
      end

      namespace :deploy do
        namespace :skype_notifications do
          task :setup do 
              TalkingCapistrano::SkypeNotification.set_notify(fetch(:skype_topic, false))
        end
        task :send_about_to_deploy do

          if TalkingCapistrano::SkypeNotification.notify?
            TalkingCapistrano::SkypeNotification.notify(say_deploy_started)
          end
        end      
      end
    end



      # Skype notifications on deploy stages
      before "deploy", "deploy:skype_notifications:setup"
      before "deploy", "deploy:skype_notifications:send_about_to_deploy"      

      # Say notifications on deploy stages
      before "deploy", "deploy:say:about_to_deploy"
      # Say + Skype notifications on deploy stages - hack to avoid stack too deep exception
      after   "deploy" do
        `#{say_command} #{say_deploy_completed} -v '#{speaker}' &`
        if TalkingCapistrano::SkypeNotification.notify?
           TalkingCapistrano::SkypeNotification.notify(say_deploy_completed)
        end
      end

end