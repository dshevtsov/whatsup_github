require_relative 'table'

# Creates the final table
module Whatsnew
  class Generator

    def initialize(date)
      @date = date
    end

    def run
      Table.new(@date).generate_markdown_table
    end
  end
end
