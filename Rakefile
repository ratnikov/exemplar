require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "exemplar"

    gem.summary = "Makes writing examples easy and fun"

    gem.email = "ratnikov@gmail.com"
    gem.homepage = "http://github.com/ratnikov/exemplar"
    gem.authors = [ "Dmitry Ratnikov" ]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Rake::TestTask.new(:test) do |test|
  test.test_files = FileList["test/**/*_test.rb"]
  test.libs << 'test'
  test.verbose = false
end

desc "Run the test suite"
task :default => :test
