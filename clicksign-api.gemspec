
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "clicksign/api/version"

Gem::Specification.new do |spec|
  spec.name          = 'clicksign-api'
  spec.version       = Clicksign::Api::VERSION
  spec.authors       = ['Francisco Martins']
  spec.email         = ['franciscomxs@gmail.com']

  spec.summary       = 'Clicksign API ruby interface'
  spec.homepage      = 'https://github.com/NexoosBR/clicksign-api'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'faraday'

  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 10.0'
  spec.add_development_dependency 'dotenv', '~> 2.5'
  spec.add_development_dependency 'pry'
end
