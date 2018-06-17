require_relative 'row'
require_relative 'pulls'

module Whatsnew
  # Creates Row objects for the future table
  class RowCollector
    attr_reader :repo, :since

    def initialize(args = {})
      @repo = args[:repo]
      @since = args[:since]
    end

    def collect_rows
      pulls.map do |pull|
        Row.new(
          repo: repo,
          pr_number: pull.number,
          pr_title: pull.title,
          pr_body: pull.body,
          date: pull.closed_at,
          pr_labels: label_names(pull.labels),
          assignee: pull.assignee.login
        )
      end
    end

    private

    def label_names(labels)
      labels.map {|label| label.name} 
    end

    def pulls
      Pulls.new(repo: repo, since: since).filtered
    end
  end
end
