require 'yaml'
module WhatsupGithub
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
            'link' => object.link,
            'contributor' => object.author,
            'profile' => object.author_url
          }
        end
      output =
        {
          'updated' => Time.now.strftime('%c').tr_s(' ', ' '),
          'entries' => entries
        }
      output.to_yaml
    end
  end
end
