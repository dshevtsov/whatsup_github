# frozen_string_literal: true

require 'singleton'

# Client authorization
module WhatsupGithub
  # Create a singleton object for EnterpriseClient.
  # Authorize with a GitHub Enterprise token from $WHATSUP_ENTERPRISE_ACCESS_TOKEN if available
  # Otherwise, use credentials from ~/.netrc
  class EnterpriseClient < Client
    include Singleton

    WHATSUP_ENTERPRISE_ACCESS_TOKEN = ENV['WHATSUP_ENTERPRISE_ACCESS_TOKEN']
    private_constant :WHATSUP_ENTERPRISE_ACCESS_TOKEN

    @@hostname = ''

    def self.host=(hostname)
      abort "ERROR: Set value for 'enterprise' in the whatsup_github configuration" if hostname.nil?
      @@hostname = hostname
    end

    def initialize
      Octokit.configure do |c|
        c.api_endpoint = "https://#{@@hostname}/api/v3/"
      end
      @client =
        if WHATSUP_ENTERPRISE_ACCESS_TOKEN
          Octokit::Client.new(access_token: WHATSUP_ENTERPRISE_ACCESS_TOKEN)
        elsif File.exist? "#{ENV['HOME']}/.netrc"
          Octokit::Client.new(netrc: true)
        end
    end
  end
end
