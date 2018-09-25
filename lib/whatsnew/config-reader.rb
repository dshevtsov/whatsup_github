require 'yaml'

module Whatsnew
  # Creates readable objects from confirurarion files
  class Config
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def read
      unless File.exist?(filename)
        raise <<-MESSAGE
        Cannot find the #{filename} file. Use a template in #{filename}.dist to create #{filename}.."
        MESSAGE
      end
      load
    end

    def load
      YAML.load_file(filename)
    end
  end
end
