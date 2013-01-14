# Talking::Capistrano

Capisrano task to notify start|end|erros of a capistrano deploy execution

* Current code is based on thr `say` command in OSX, espeak can also be used, however, I didn't bother yet. PR always welcome

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

In your deploy.rb, enjoy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
