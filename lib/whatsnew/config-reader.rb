require 'yaml'

module Whatsnew
  # Creates readable objects from confirurarion files
  class Config
    attr_reader :config

    def initialize(filename)
      @filename = filename
      @config = {}
    end

    def read(*options)
      unless File.exist?(@filename)
        dist_file = File.basename(@filename, '.yml') + '.yml.dist'
        FileUtils.cp dist_file, @filename
      end
      load_from_yaml.dig options.join ','
    end

    def load_from_yaml
      @config = YAML.load_file @filename
      return {} unless @config
      @config
    end
  end
end
