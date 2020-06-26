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
      required_labels.each do |label|
        issues += search_issues(label).items
      end
      optional_labels.each do |label|
        issues += search_issues_with_magic_word(label).items
      end
      issues
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

    def client
      Octokit::Client.new(:netrc => true)
    end

    def search_issues(label)
      auto_paginate
      client.search_issues("repo:#{repo} label:\"#{label}\" merged:>=#{since} base:#{base_branch}")
    end

    def search_issues_with_magic_word(label)
      auto_paginate
      client.search_issues("repo:#{repo} label:\"#{label}\" merged:>=#{since} base:#{base_branch} \"#{magic_word}\" in:body")
    end

    def auto_paginate
      Octokit.auto_paginate = true
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require 'date'
  two_weeks_ago = (Date.today - 14).to_s
  pulls = WhatsupGithub::Pulls.new(repo: 'magento/devdocs', since: two_weeks_ago)
  p pulls.filtered
end
