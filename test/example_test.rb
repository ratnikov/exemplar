require 'test_helper'

module Exemplar
  class ExampleTest < Test::Unit::TestCase
    def test_declaring_example
      test_example = example("test example", :foo => 'bar') {  }

      assert_equal 'test example', test_example.name
      assert_equal({ :foo => 'bar' }, test_example.options)

      assert_equal [ test_example ], Example.examples, "Should register the example with the runner"
    end

    def test_running_example
      test_example = example("test example") { |example| self.invoke_something(example); :block_return }

      mock( self ).invoke_something(test_example)

      assert_equal :block_return, test_example.run, "Should run the example block and return whatever it returns"
    end

    def test_before_callback
      Example.before :do_foo

      assert_equal [ :do_foo ], Example.before_callbacks, "Should register a callback"

      example = example("test example") { :block_return }

      mock( example ).do_foo.returns true

      assert_equal :block_return, example.run
    end

    def test_before_callback_cancellation
      Example.before :false_callback

      example = example("test example") { flunk("Wasn't supposed to be run") }

      mock( example ).false_callback.returns false

      assert_equal false, example.run, "Should return that example failed to run"
    end

    def test_exception_handling
      error = Exception.new "bad error"

      example = example("erroring example") { raise error }

      mock( example ).rescue_error(error).returns :rescue_return

      assert_equal :rescue_return, example.run, "should return whatever rescue returned"
    end
  end
end
