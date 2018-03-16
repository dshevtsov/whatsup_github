require_relative 'row'
require_relative 'pulls'

# Creates Row objects for the future table
module Whatsnew
  class RowCollector

    def initialize(repo, since)
      @repo = repo
      @since = since
    end

    def collect_rows
      pulls.collect do |pull|
        Row.new(
          @repo,
          pull.number,
          pull.title,
          pull.body,
          pull.closed_at,
          label_names(pull.labels)
        )
      end
    end

    private

    def label_names(labels)
      label_names = []
      labels.each do |label|
        label_names << label.name
      end
      label_names
    end

    def pulls
      Pulls.new(@repo, @since).filtered
    end
  end
end