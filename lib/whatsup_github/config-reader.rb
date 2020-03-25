require 'yaml'
require 'singleton'

module WhatsupGithub
  # Creates readable objects from confirurarion files
  class Config
    attr_reader :config
    include Singleton

    def initialize
      @file = '.whatsup.yml'
      @config = {}
    end

    def read(*options)
      unless File.exist?(@file)
        dist_file = File.expand_path("../template/#{@file}", __dir__)
        FileUtils.cp dist_file, @file
      end
      load_from_yaml.dig options.join ','
    end

    def load_from_yaml
      @config = YAML.load_file @file
      return {} if !@config
      @config
    end
  end
end
