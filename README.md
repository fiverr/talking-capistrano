# Talking::Capistrano

Capisrano task to notify start|end|erros of a capistrano deploy execution
Current Notification methods supported:
*. Skype Group - via some topic
*. speaker voice - via OSX's `say` command 

* Current code is based on the `say` command in OSX and the 'skypemac' gem, espeak can also be used, however, I didn't bother yet. PR always welcome

## Installation

Add this line to your application's Gemfile:

    gem 'talking-capistrano'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install talking-capistrano

## Usage

Simply add:

    require 'talking-capistrano'

In your Capfile, enjoy

To get the Skype Notification to kick in, simply add, in the deploy.rb file (or the specific environment, eg. production.rb):

    set :skype_topic, "Production Team"
 
This will kick a search on the Skype chats with this as the topic, and will send a mesage to that group.
If topic not found, it will simply be ignored.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
