# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'i18n-backend-side_by_side'
  spec.version       = File.read('VERSION').strip
  spec.authors       = ['Philipe Fatio', 'Pratik Mukerji']
  spec.email         = ['me@phili.pe', 'pratik@electricfeel.com']
  spec.summary       = %q{Tired of jumping between language files when translating keys? Stop jumping and have all the languages side by side.}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/electric-feel/i18n-backend-side_by_side'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_dependency 'i18n', '>= 1.10.0'
  spec.add_dependency 'activesupport', '>= 6.0.0'
end
