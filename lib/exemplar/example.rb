module Exemplar
  class Example
    include Loggable

    class << self
      def before_callbacks
        @before_callbacks ||= []
      end

      def before(*before_methods)
        before_callbacks.push *before_methods
      end

      def examples
        @examples ||= []
      end
    end

    attr_reader :name, :options, :block

    def initialize(name, options, block)
      @name, @options, @block = name, options, block

      self.class.examples << self
    end

    def run
      log "Running example #{name}..."

      block_return = run_before_callbacks && block.call(self)

      log "Done running example #{name}"

      block_return
    rescue Exception => error
      rescue_error(error)
    end

    private

    def rescue_error(error)
      log "Whoops, seems like something went wrong. Here's the error message: %s." % error.message
      nil
    end

    def run_before_callbacks
      self.class.before_callbacks.all? { |callback| send(callback) }
    end

    def runner
      Exemplar::Runner
    end
  end
end

def example(name, options = nil, &block)
  Exemplar::Example.new(name, options, block)
end
