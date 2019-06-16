require 'octokit'
require_relative 'config-reader'

module WhatsupGithub
  # Gets pull filtered pull requests from GitHub
  class Pulls
    attr_reader :since, :repo

    def initialize(args = {})
      @repo = args[:repo]
      @since = args[:since]
    end

    def filtered
      issues = []
      labels.each do |label|
        issues += search_issues(label).items
      end
      issues
    end

    private

    # def access_token
    #   credentials.read 'github_token'
    # end

    def configuration
      Config.instance
    end

    def labels
      configuration.read 'labels'
    end

    def base_branch
      configuration.read 'base_branch'
    end

    def client
      Octokit::Client.new(:netrc => true)
    end

    def search_issues(label)
      auto_paginate
      client.search_issues("repo:#{repo} label:\"#{label}\" merged:>=#{since} base:#{base_branch}")
    end

    def auto_paginate
      Octokit.auto_paginate = true
    end
  end
end
