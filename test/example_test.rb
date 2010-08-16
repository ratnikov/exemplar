require 'test_helper'

module Exemplar
  class ExampleTest < Test::Unit::TestCase
    def setup
      # make sure there aren't any lingering examples declared
      Runner.examples.clear
    end

    def test_declaring_example
      test_example = example("test example") {  }

      assert_equal [ test_example ], Runner.examples, "Should register the example with the runner"
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

    def teardown
      # clear the callbacks to avoid future test breakage
      Example.before_callbacks.clear
    end
  end
end
