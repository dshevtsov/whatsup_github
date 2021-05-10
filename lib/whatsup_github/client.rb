# frozen_string_literal: true

require 'singleton'

# Client authorization
module WhatsupGithub
  # Create a singleton object for Client.
  # Authorize with a GitHub token from $WHATSUP_GITHUB_ACCESS_TOKEN if available
  # Otherwise, use credentials from ~/.netrc
  # Otherwise, continue as a Guest
  class Client
    include Singleton

    WHATSUP_GITHUB_ACCESS_TOKEN = ENV['WHATSUP_GITHUB_ACCESS_TOKEN']
    private_constant :WHATSUP_GITHUB_ACCESS_TOKEN

    def initialize
      @client =
        if WHATSUP_GITHUB_ACCESS_TOKEN
          Octokit::Client.new(access_token: WHATSUP_GITHUB_ACCESS_TOKEN)
        elsif File.exist? "#{ENV['HOME']}/.netrc"
          Octokit::Client.new(netrc: true)
        else
          Octokit::Client.new
        end
    end

    def search_issues(query)
      @client.search_issues(query)
    end

    def pull_request(repo, number)
      @client.pull_request(repo, number)
    end

    def org_members(org)
      @client.org_members(org)
    end
  end
end
