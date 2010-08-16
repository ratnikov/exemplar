require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.test_files = FileList["test/**/*_test.rb"]
  test.libs << 'test'
  test.verbose = false
end

desc "Run the test suite"
task :default => :test
