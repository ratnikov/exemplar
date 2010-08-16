require 'optparse'

module Exemplar
  class Runner
    attr_reader :examples

    def initialize(examples, options = nil)
      @examples = examples
      @match_regex = options && options[:match]
    end

    def run
      examples.select { |example| run?(example) }.each { |example| example.run }
    end

    def run?(example)
      @match_regex.nil? || example.name =~ @match_regex
    end

    def self.parse_options!(argv)
      options = {}

      OptionParser.new do |opt|
        opt.banner = "Exemplar automatic example runner.\n"
        opt.banner << "Usage: #{$0} [options]"

        opt.on
        opt.on("-e", "--example [REGEX]", "Run examples matching the regex.") do |regex|
          options[:match] = Regexp.new(regex)
        end

        opt.on_tail
      end.parse!(argv)

      options
    rescue OptionParser::ParseError => e
      puts "%s. Run `#{$0} --help` for help." % e
      exit false
    end
  end
end

Kernel.at_exit do
  Exemplar::Runner.new(Exemplar::Example.examples, Exemplar::Runner.parse_options!(ARGV)).run
end
