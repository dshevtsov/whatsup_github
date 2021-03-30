# frozen_string_literal: true

module WhatsupGithub
  # Members of an organization
  class Members
    def initialize(org)
      @org = org
    end

    def client
      Octokit::Client.new(netrc: true)
    end

    def members
      client.org_members @org
    end
  end
end
