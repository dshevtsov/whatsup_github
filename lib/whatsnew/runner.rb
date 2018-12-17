require 'fileutils'
require_relative 'generator'
require_relative 'options'
require_relative 'config-reader'
require_relative 'yaml-formatter'
require_relative 'table'

module Whatsnew
  class Runner
    attr_reader :args

    def initialize(args)
      @args = args
      @generator = Generator.new since
      @config = Whatsnew::Config.new('config.yml')
      @content ||= @generator.content
    end

    def run
      format = @config.read 'output_format'
      raise 'Cannot find "output_format" in config.yml' unless format
      table if format.include? 'markdown'
      data if format.include? 'yaml'
    end

    def write_results file, formatter
      formatted_content = @generator.run formatter, @content
      File.write file, formatted_content
      puts "Done!\nOpen \"#{file}\" to see the result."
    end

    def options
      Options.parse(args)
    end

    def since
      options.since.to_s
    end

    def table
      write_results 'output/whats-new-on-devdocs.md', Table.new
    end

    def data
      write_results 'output/whats-new.yml', YAMLFormatter.new
    end
  end
end
