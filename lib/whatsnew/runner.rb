require_relative 'generator'
require_relative 'options'

module Whatsnew
  class Runner
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def output_file
      'whats-new-on-devdocs.md'
    end

    def run
      open(output_file, 'w') { |file| file << table }
      puts "Done!\nOpen \"#{output_file}\" to see the result."
    end

    def options
      Options.new(argv)
    end

    def date
      options.since
    end

    def table
      Generator.new(date).run
    end
  end
end
