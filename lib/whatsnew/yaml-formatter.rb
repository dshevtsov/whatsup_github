require 'yaml'
module Whatsnew
  # Table containing Rows
  class YAMLFormatter
    # def initialize(since)
    #   @collector = RowCollector.new(since: since)
    # end

    def generate_output_from(content)
      entries =
        content.collect do |object|
          {
            'description' => object.description,
            'versions' => object.versions,
            'type' =>  object.type,
            'date' => object.date,
            'link' => object.link
          }

        end
      output =
        {
          'updated' => Time.now.strftime('%c'),
          'entries' => entries
        }
      output.to_yaml
    end
  end
end
