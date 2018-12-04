require 'octokit'
require_relative 'config-reader'

module Whatsnew
  # Gets pull filtered pull requests from GitHub
  class Pulls
    attr_reader :since, :repo

    def initialize(args = {})
      @repo = args[:repo] || default_repo # the default repo is public devdocs
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

    def default_repo
      'magento/devdocs'
    end

    def access_token
      credentials.read['github_token']
    end

    def config
      Whatsnew::Config.new('config.yml')
    end

    def labels
      config.read['labels']
    end

    def base_branch
      config.read['base_branch']
    end

    def credentials
      Whatsnew::Config.new('credentials.yml')
    end

    def client
      Octokit::Client.new(access_token: access_token)
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
