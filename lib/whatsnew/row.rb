module Whatsnew
  # Row to be converted to entry in future table
  class Row
    attr_reader :body, :title, :labels, :pr_number, :assignee, :link
    def initialize(args)
      @repo = args[:repo]
      @title = args[:pr_title]
      @body = args[:pr_body]
      @date = args[:date]
      @labels = args[:pr_labels]
      @assignee = args[:assignee]
      @pr_number = args[:pr_number]
      @link = args[:pr_url]
    end

    UPDATED_MASK = 'Major update'.freeze
    UPDATED_PHRASE = 'Major update'.freeze
    NEW_MASK = 'New topic'.freeze
    NEW_PHRASE = 'New topic'.freeze
    TECHNICAL_MASK = 'Technical'.freeze
    TECHNICAL_PHRASE = 'Technical changes'.freeze

    def versions
      label_versions = labels.select { |label| label.start_with?(/\A\d\.\d/) }
      label_versions.join(', ')
    end

    def date
      @date.strftime('%B %-e, %Y')
    end

    def type
      labels_string = labels.join(' ')
      label_type = /#{ UPDATED_MASK }|#{ NEW_MASK }|#{ TECHNICAL_MASK }/.match(labels_string)
      case label_type.to_s
      when /#{ UPDATED_MASK }/
        UPDATED_PHRASE
      when /#{ NEW_MASK }/
        NEW_PHRASE
      when /#{ TECHNICAL_MASK }/
        TECHNICAL_PHRASE
      end
    end

    def parse_body
      whatsnew_splited = body.split('whatsnew')[-1]
      newline_splited = whatsnew_splited.split("\n")
      cleaned_array = newline_splited.map { |e| e.delete "\r\*" }
      cleaned_array.delete('')
      striped_array = cleaned_array.map(&:strip)
      striped_array.join('<br/>')
    end

    def description
      if body.include?('whatsnew')
        parse_body
      else
        message = "MISSING WHATSNEW in the #{type} PR \##{pr_number}: \"#{title}\" assigned to #{assignee} (#{link})"
        puts message
        message
      end
    end
  end
end
