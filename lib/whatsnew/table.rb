require_relative 'row_collector'

module Whatsnew
  # Table containing Rows
  class Table
    attr_reader :since

    def initialize(since)
      @since = since
    end

    def repos
      { private: 'magento/devdocs_internal',
        public: 'magento/devdocs' }
    end

    def collect_public
      collector = create_collector(repos[:public], since)
      collector.collect_rows
    end

    def collect_private
      collector = create_collector(repos[:private], since)
      collector.collect_rows
    end

    def collect_all
      collect_public.concat(collect_private)
    end

    def sort_all_by_date
      collect_all.sort_by do |c|
        Date.parse(c.date)
      end
      collect_all.reverse!
    end

    def generate_markdown_array
      sort_all_by_date.collect do |object|
        "#{object.description}|#{object.versions}|#{object.type}|#{object.date}\n"
      end
    end

    def generate_markdown_table
      generate_markdown_array.join
    end

    private

    def create_collector(repo, since)
      RowCollector.new(repo: repo, since: since)
    end
  end
end

# table = Table.new('1 July')
# collection = table.sort_all_by_date
