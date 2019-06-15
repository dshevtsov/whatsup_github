module WhatsupGithub
  # Creates the final table
  class Generator
    def initialize(since)
      @collector = RowCollector.new(since: since)
    end

    def content
      @collector.sort_by_date
    end

    def run formatter, content
      formatter.generate_output_from content
    end
  end
end
