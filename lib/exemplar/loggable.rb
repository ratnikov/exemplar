module Exemplar
  module Loggable
    class << self
      def log?
        @log.nil? ? true : @log
      end

      def log=(log)
        @log = log
      end
    end

    def log(message)
      puts message if Loggable.log?
    end
  end
end
