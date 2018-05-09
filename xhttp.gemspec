# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xhttp/version'

Gem::Specification.new do |spec|
  spec.name          = 'xhttp'
  spec.version       = Xhttp::VERSION
  spec.authors       = ['codebrk']
  spec.email         = ['codebreakme@gmail.com']

  spec.summary       = %q{A HTTP library inspired by Python requests module}
  spec.homepage      = 'https://github.com/codebrk/xhttp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").push('lib/xhttp/get.rb', 'lib/xhttp/post.rb').reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
