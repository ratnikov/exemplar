module Exemplar
  class Example
    include Loggable

    attr_reader :name, :block

    def initialize(name, options, block)
      @name, @block = name, block

      runner.register(self)
    end

    def run
      log "Running example #{name}..."

      block_return = block.call(self)

      log "Done running example #{name}"

      block_return
    rescue Exception => error
      log "Whoops, seems like something went wrong. Here's the error message: %s." % error.message
      nil
    end

    private

    def runner
      Exemplar::Runner
    end
  end
end

def example(name, options = nil, &block)
  Exemplar::Example.new(name, options, block)
end
