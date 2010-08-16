
begin
  require 'bundler'

  Bundler.setup
rescue LoadError => error
  warn "Bundler doesn't seem to be installed. Please install bundler and run: bundle install"
  exit
end

require 'test/unit'
require 'rr'

require 'exemplar'

# disable the logging for the tests
Exemplar::Loggable.log = false

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end
