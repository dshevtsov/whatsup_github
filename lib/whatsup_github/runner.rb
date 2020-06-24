require 'fileutils'
require_relative 'generator'
require_relative 'config-reader'
require_relative 'yaml-formatter'
require_relative 'table'

module WhatsupGithub
  class Runner

    def initialize(date)
      @generator = Generator.new date
      @config = Config.instance
      @content ||= @generator.content
    end

    def run
      format = @config.output_format
      raise 'Cannot find "output_format" in config.yml' unless format
      table if format.include? 'markdown'
      data if format.include? 'yaml'
    end

    def write_results file, formatter
      formatted_content = @generator.run formatter, @content
      check_dir_at File.dirname file
      File.write file, formatted_content
      puts "Done!\nOpen \"#{file}\" to see the result."
    end

    def check_dir_at(filepath)
      FileUtils.mkdir_p filepath unless Dir.exist? filepath
    end

    def table
      write_results 'tmp/whats-new-on-devdocs.md', Table.new
    end

    def data
      write_results 'tmp/whats-new.yml', YAMLFormatter.new
    end
  end
end
