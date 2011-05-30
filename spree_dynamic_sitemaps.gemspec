Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_dynamic_sitemaps'
  s.version     = '0.50.2'
  s.summary     = 'Google sitemap for Spree'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'asha79'
  s.homepage          = 'https://github.com/asha79/spree_dynamic_sitemaps'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

end
