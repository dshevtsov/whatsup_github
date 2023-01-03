# frozen_string_literal: true

require 'octokit'
require_relative 'config_reader'
require_relative 'client'

module WhatsupGithub
  # Gets issues found on GitHub by query
  class Pulls
    attr_reader :since, :repo

    def initialize(args = {})
      @repo = args[:repo]
      @since = args[:since]
    end

    def data
      pull_requests = []
      filtered_numbers.each do |number|
        pull_requests << client.pull_request(@repo, number)
      end
      pull_requests
    end

    private

    # def access_token
    #   credentials.dig 'github_token'
    # end

    def configuration
      Config.instance
    end

    def optional_labels
      configuration.optional_labels
    end

    def required_labels
      configuration.required_labels
    end

    def magic_word
      configuration.magic_word
    end

    def base_branch
      configuration.base_branch
    end

    # Authorize with a GitHub token from $WHATSUP_GITHUB_ACCESS_TOKEN if available
    # Otherwise, use credentials from ~/.netrc
    # Otherwise, continue as a Guest
    def client
      Client.instance
    end

    def search_issues(label)
      auto_paginate
      query = "repo:#{repo} label:\"#{label}\" merged:>=#{since} base:#{base_branch} is:pull-request"
      puts "Searching on GitHub by query #{query}"
      client.search_issues(query)
    end

    def search_issues_with_magic_word(label)
      auto_paginate
      query = "repo:#{repo} label:\"#{label}\" merged:>=#{since} base:#{base_branch} \"#{magic_word}\" in:body is:pull-request"
      puts "Searching on GitHub by query #{query}"
      client.search_issues(query)
    end

    def auto_paginate
      Octokit.auto_paginate = true
    end

    def filtered_issues
      issues = []
      required_labels.each do |label|
        issues += search_issues(label).items
      end
      optional_labels.each do |label|
        issues += search_issues_with_magic_word(label).items
      end
      issues
    end

    def filtered_numbers
      filtered_issues.map(&:number)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require 'date'
  two_weeks_ago = (Date.today - 14).to_s
  pulls = WhatsupGithub::Pulls.new(repo: 'magento/devdocs', since: two_weeks_ago)
  p pulls.data
end
