# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vg_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "vg_tools"
  spec.version       = VgTools::VERSION
  spec.authors       = ["JackMarx"]
  spec.email         = ["seriousfools@gmail.com"]

  spec.summary       = "To help teach programing terminal videogames in ruby"
  spec.description   = "This gem was developed to provide tools for beginner ruby students making terminal based videogames and cultivating a taste for programming in the ruby language."
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = [
                        'lib/vg_tools.rb', 
                        'lib/helper_tools/move_methods.rb',
                        'lib/helper_tools/checking_methods.rb',
                        'lib/helper_tools/place_blocks.rb',
                        'lib/helper_tools/update_map.rb',
                        'lib/vg_tools/version.rb'
                        ]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/helper_tools"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
