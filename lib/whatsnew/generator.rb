require_relative 'table'

module Whatsnew
  # Creates the final table
  class Generator
    def initialize(date)
      @date = date
    end

    def run
      Table.new(@date).generate_markdown_table
    end
  end
end
