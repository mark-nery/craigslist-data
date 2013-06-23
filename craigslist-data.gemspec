# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'craigslist/data/version'

Gem::Specification.new do |spec|
  spec.name          = "craigslist-data"
  spec.version       = Craigslist::Data::VERSION
  spec.authors       = ["mark nery"]
  spec.email         = ["marknery@gmail.com"]
  spec.description   = %q{a gem to scrape data off craigslist}
  spec.summary       = %q{a gem to scrape data off craigslist}
  spec.homepage      = "https://github.com/mark-nery/craigslist-data"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.post_install_message = <<-MESSAGE
!    The 'craigslist-data' gem has been deprecated and has been replaced by 'craigslist_scraper'.
!    See: http://rubygems.org/gems/craigslist_scraper
!    And: https://github.com/mark-nery/craigslist_scraper
MESSAGE
  spec.require_paths = ["lib"]
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
