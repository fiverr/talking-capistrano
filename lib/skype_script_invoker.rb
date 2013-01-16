class SkypeScriptInvoker

  attr_accessor  :target_chat_id

  @@SCRIPT_PATH = File.join(File.dirname(__FILE__), "../scripts/")

  def initialize(topic)
    ## Initilize the chat_id
    @target_chat_id  = get_chat_id_for_topic topic
  end

  def get_chats
    `osascript #{@@SCRIPT_PATH}skype_get_chats.APPLESCRIPT`
  end

  def get_topic_for_chat(chat_id)
    `osascript #{@@SCRIPT_PATH}skype_get_topic_for_chat.APPLESCRIPT '#{chat_id}'`
  end

  def get_chat_id_for_topic(target_topic ="dummy_stuff")

    found_chat_id = nil
    chats = get_chats
    chats.gsub! "CHATS ", ""

    chats.split(",").each do |chat_id|
      details = (get_topic_for_chat chat_id).chomp.split("TOPIC ")
      topic = details[1].chomp if details.size > 1
      found_chat_id  = chat_id if topic == target_topic
    end

    found_chat_id
  end

  def send_message(message)
    `osascript #{@@SCRIPT_PATH}skype_send_message.APPLESCRIPT '#{@target_chat_id}' '#{message}'`  unless @target_chat_id.nil?
    #puts "Sending '#{@@target_chat_id}' '#{message}' " unless @target_chat_id.nil?
  end


end