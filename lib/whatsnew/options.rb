require 'optparse'
require 'optparse/date'
require 'ostruct'
require 'pp'

module Whatsnew
  class Options
    Version = '6'.freeze

    class ScriptOptions
      attr_accessor :verbose, :since
  
      def initialize
        self.verbose = false
        self.since = Date.today - 7
      end
    end

    def self.parse args
      # Collect the options specified on the command line in *options*.
      @options = ScriptOptions.new
      option_parser.parse! args
      @options
    end

    attr_reader :parser, :options

    def self.option_parser
      @parser ||= OptionParser.new do |parser|
        parser.banner = "Usage: whats-new-on-devdocs [--since] ['date']"
        parser.separator ""
        parser.separator "Example: whats-new-on-devdocs --since 'aug 17'"
        parser.separator ""
        parser.separator "If --since or 'date' was not provided, the tool generates the updates for the past week."
        parser.separator ""
        parser.separator "Specific options:"
      
        # Add custom options.
        specify_since_option parser
        
        parser.separator ""
        parser.separator "Common options:"
        # Print options summary.
        parser.on_tail("-h", "--help", "Show this message") do
          puts parser
          exit
        end

        # Typical switch to print the version.
        parser.on_tail("-v", "--version", "Show version") do
          puts Version
          exit
        end
      end
    end

    def self.specify_since_option(parser)
      parser.on("-s", "--since [DATE]", Date, "Pull updates since the given date till now. By default, it is 'today - 7 days'") do |time|
        @options.since = time
      end
    end
  end
end