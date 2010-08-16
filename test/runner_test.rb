require 'test_helper'

class RunnerTest < Test::Unit::TestCase
  def test_examples_running
    run_examples = []

    example1 = example("first test example") { |e| run_examples << e }
    example2 = example("second test example") { |e| run_examples << e }

    Exemplar::Runner.run

    assert_equal [ example1, example2 ], run_examples, "Should run the examples in order declared"
  end
end
