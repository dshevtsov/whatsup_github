require 'optparse'

module Whatsnew
    class Options
        Version = '0.0.1'

        attr_reader :since

        def initialize(argv)
            parse(argv)
            @since = argv
        end

        private

        def parse(argv)
            OptionParser.new do |opts|
                opts.banner = "Usage: whats-new-on-devdocs-from [options] date..."

                opts.on("-v", "--version", Version) do
                    puts opts
                    exit
                end

                begin
                    argv = ["-v"] if argv.empty?
                    opts.parse!(argv)
                rescue OptionParser::ParseError => e
                    STDERR.puts e.message, "/n", opts
                    exit(-1)
                end
            end
        end
    end
end
