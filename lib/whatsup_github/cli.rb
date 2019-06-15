require 'thor'
require "whatsup_github/runner"
module WhatsupGithub
  class CLI < Thor
    desc "since DATE", "Filters pull requests since the specified date till now."

    def since(date = Date.today - 7)

      runner = WhatsupGithub::Runner.new(Date.parse(date.to_s))
      runner.run
    end
    default_task :since
  end
end