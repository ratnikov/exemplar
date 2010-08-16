require 'test_helper'

module Exemplar
  class ExampleTest < Test::Unit::TestCase
    def test_declaring_example
      test_example = example("test example") {  }

      assert_equal [ test_example ], Exemplar::Runner.examples, "Should register the example with the runner"
    end

    def test_running_example
      test_example = example("test example") { |example| self.invoke_something(example); :block_return }

      mock( self ).invoke_something(test_example)

      assert_equal :block_return, test_example.run, "Should run the example block and return whatever it returns"
    end
  end
end
