$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rok_blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.require_path ='lib'
  s.test_files = Dir["test/**/*"]


  s.name        = "rok_blog"
  s.version     = RokBlog::VERSION
  s.authors     = ["Sean Earle"]
  s.email       = ["sean.r.earle@gmail.com"]
  s.homepage    = "http://www.oequacki.com/"
  s.summary     = "Blog engine to be used with rok_cms"
  s.description = "This is a blog engine designed to be used with the rok_cms gem."
  s.license     = "Beerware"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.require_path ='lib'
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  #s.add_dependency "rok_base"
end
