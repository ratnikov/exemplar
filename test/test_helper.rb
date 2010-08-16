
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

class << Exemplar::Runner

  # stub out the option parsing to make sure it doesn't conflict with test/unit options
  # Yea, it's ugly... :(
  alias_method :default_parse_options!, :parse_options!
  def parse_options!(args)
    args == ARGV ? { } : default_parse_options!(args)
  end
end

class Test::Unit::TestCase
  include RR::Adapters::TestUnit

  setup
  def setup_examples
    # make sure there aren't any lingering examples declared
    Exemplar::Example.examples.clear
  end

  teardown
  def teardown_callbacks
    # clear the callbacks to avoid future test breakage
    Exemplar::Example.before_callbacks.clear
  end
end
