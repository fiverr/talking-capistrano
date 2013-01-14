# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'talking-capistrano/version'

Gem::Specification.new do |gem|
  gem.name          = "talking-capistrano"
  gem.version       = Talking::Capistrano::VERSION
  gem.authors       = ["Avner Cohen"]
  gem.email         = ["avner.cohen@fiverr.com"]
  gem.description   = %q{Capisrano task to notify start|end|erros of a capistrano deploy execution}
  gem.summary       = %q{Capisrano task to notify start|end|erros of a capistrano deploy execution}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.files << "lib/talking-capistrano.json"
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
