require_relative 'row_collector'

# I expect an array of hashes
module Whatsnew
  class Table

    def initialize(since)
      @repos = { private: 'magento/devdocs_internal', public: 'magento/devdocs' }
      @since = since
    end

    def collect_public
      collector = create_collector(@repos[:public], @since)
      collector.collect_rows
    end

    def collect_private
      collector = create_collector(@repos[:private], @since)
      collector.collect_rows
    end

    def collect_all
      collect_public.concat(collect_private)
    end

    def sort_all_by_date
      collect_all.sort_by { |c| DateTime.parse(c.date) }.reverse!
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
      RowCollector.new(repo, since)
    end
  end
end

# table = Table.new('1 July')
# collection = table.sort_all_by_date
