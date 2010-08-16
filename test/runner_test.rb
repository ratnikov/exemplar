require 'test_helper'

module Exemplar
  class RunnerTest < Test::Unit::TestCase
    def test_examples_running
      run_examples = []

      example1 = example("first test example") { |e| run_examples << e }
      example2 = example("second test example") { |e| run_examples << e }

      Runner.new([ example1, example2 ]).run

      assert_equal [ example1, example2 ], run_examples, "Should run the examples in order declared"
    end

    def test_example_regex
      foo = example("a foo example") { }
      bar = example("a bar example") { }

      # should run foo, but not run bar
      mock( foo ).run.once 
      mock( bar ).run.never

      Runner.new([ foo, bar], { :match => /foo/ }).run
    end

    def test_parse_options!
      assert_equal({ :match => /foo bar/ }, Runner.parse_options!([ '-e', 'foo bar' ]))
    end
  end
end
