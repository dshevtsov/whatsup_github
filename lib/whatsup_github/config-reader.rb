require 'yaml'

module WhatsupGithub
  # Creates readable objects from confirurarion files
  class Config
    attr_reader :config

    def initialize(file)
      @file = '.whatsnew.yml'
      @config = {}
    end

    def read(*options)
      unless File.exist?(@file)
        filename = File.basename(@file, '.yml') + '.yml.dist'
        dist_file = File.expand_path("../template/#{filename}", __dir__)
        FileUtils.cp dist_file, @file
      end
      load_from_yaml.dig options.join ','
    end

    def load_from_yaml
      @config = YAML.load_file @file
      return {} unless @config
      @config
    end
  end
end
