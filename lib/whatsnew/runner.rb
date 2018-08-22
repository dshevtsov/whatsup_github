require_relative 'generator'
require_relative 'options'

module Whatsnew
  class Runner
    attr_reader :args

    def initialize(args)
      @args = args
    end

    def output_file
      'whats-new-on-devdocs.md'
    end

    def run
      open(output_file, 'w') { |file| file << table }
      puts "Done!\nOpen \"#{output_file}\" to see the result."
    end

    def options
      Options.parse(args)
    end

    def date
      options.since.to_s
    end

    def table
      Generator.new(date).run
    end
  end
end
