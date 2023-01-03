# frozen_string_literal: true

require 'thor'
require 'whatsup_github/runner'
require 'whatsup_github/version'
module WhatsupGithub
  # CLI options
  class CLI < Thor
    desc 'since DATE', 'Filters pull requests since the specified date till now. Default: last 7 days.'
    def since(date = Date.today - 7)
      runner = WhatsupGithub::Runner.new(Date.parse(date.to_s))
      runner.run
    end

    desc 'version', 'Current version of the gem'
    def version
      puts WhatsupGithub::VERSION
    end
  end
end
