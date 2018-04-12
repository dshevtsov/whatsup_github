require 'octokit'
require 'time'
require'yaml'

# Gets pull requests from GitHub
module Whatsnew
  class Pulls

    def initialize(repo, since)
      @repo = repo
      @since = to_time(since)
      @filtered ||= filtered
    end

    def filtered
      updated_topics.items + new_topics.items + technical_changes.items
    end

    def updated_topics
      search_issues('Doc update')
    end

    def new_topics
      search_issues('New doc')
    end

    def technical_changes
      search_issues('Technical')
    end

    private

    def access_token
      unless File.exist?('credentials.yml')
        raise "#{Dir.pwd} Cannot find a file with your internal github token. Please use \"credentials.yml.dist\" to create \"credentials.yml\" and enter your internal github token."
      end
      YAML.load_file('credentials.yml')
    end

    def read_config
      unless File.exist?('config.yml')
        raise 'Cannot find a file with your configuration settings.'
        Dir.pwd
      end
      YAML.load_file('config.yml')
    end

    def client
      Octokit::Client.new(access_token: access_token['github_token'])
    end

    def search_issues(label)
      auto_paginate
      client.search_issues("repo:#{@repo} label:\"#{label}\" merged:>=#{@since} base:#{read_config['base_branch']}")
    end

    def auto_paginate
      Octokit.auto_paginate = true
    end

    def to_time(date)
      time = Time.parse(date.join)
      time.strftime('%Y-%m-%d')
    end
  end
end
# test: pulls = Pulls.new('magento/devdocs_internal', '1 May')
