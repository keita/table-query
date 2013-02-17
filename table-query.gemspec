# -*- ruby -*-
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'table-query/version'

Gem::Specification.new do |gem|
  gem.name          = "table-query"
  gem.version       = TableQuery::VERSION
  gem.authors       = ["Keita Yamaguchi"]
  gem.email         = ["keita.yamaguchi@gmail.com"]
  gem.description   = %q{table-query is a library to query table data by easy way.}
  gem.summary       = %q{query table data by easy way}
  gem.homepage      = "https://github.com/keita/table-query"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency "bacon"
end
