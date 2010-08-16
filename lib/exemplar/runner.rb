module Exemplar
  module Runner
    extend self

    def register(example)
      examples << example
    end

    def run
      examples.each { |example| example.run }
    end

    def examples
      @examples ||= []
    end
  end
end

Kernel.at_exit { Exemplar::Runner.run }
