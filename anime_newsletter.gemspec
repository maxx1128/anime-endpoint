# coding: utf-8
lib = File.expand_path('./lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "Anime Newsletter"
  spec.version       = '1.0'
  spec.authors       = ["Maxwell Antonucci"]
  spec.email         = [""]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "http://maxwellantonucci.com/"
  spec.license       = "MIT"

  spec.files         = ['lib/anime_newsletter.rb']
  spec.executables   = ['bin/anime_newsletter']
  spec.test_files    = ['spec']
  spec.require_paths = ["lib"]
end
