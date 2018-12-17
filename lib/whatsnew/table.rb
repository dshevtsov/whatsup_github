require_relative 'row_collector'

module Whatsnew
  # Table containing Rows
  class Table

    # def initialize(since)
    #   @collector = RowCollector.new(since: since)
    # end

    def generate_output_from(content)
      content.collect do |object|
        "| #{object.description} | #{object.versions} | #{object.type} | #{object.date} |\n"
      end.join
    end
  end
end
