require_relative 'generator'
require_relative 'options'

module Whatsnew
    class Runner
        def initialize(argv)
            @options = Options.new(argv)
        end

        def run
            date = @options.since
            table = Generator.new(date).run
            open('whats-new-on-devdocs.md', 'w') {|file| file << table
            }
        end
    end
end


