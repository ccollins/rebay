require "rake"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "rebay"
    gem.summary = "Client for the RESTful JSON ebay finding and shopping api"
    gem.email = "chuck.collins@gmail.com"
    gem.homepage = "http://github.com/ccollins/rebay"
    gem.authors = ["Chuck Collins"]
    gem.files = Dir["*", "{lib}/**/*"]
    gem.add_dependency("json")
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end