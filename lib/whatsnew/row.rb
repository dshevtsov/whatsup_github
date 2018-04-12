# Row to be converted to entry in future table
module Whatsnew
  class Row
    attr_reader :date
    def initialize(repo, issue_number, pr_title, pr_body, pr_merged_at, issue_labels)
      @repo = repo
      @issue_number = issue_number
      @title = pr_title
      @body = pr_body
      @date = pr_merged_at.strftime('%b %d')
      @labels = issue_labels
    end

    UPDATED_MASK = 'update'
    UPDATED_PHRASE = 'Major updates'
    NEW_MASK = 'New doc'
    NEW_PHRASE = 'New topic'
    TECHNICAL_MASK = 'Technical'
    TECHNICAL_PHRASE = 'Technical changes'

    def versions
      label_versions = @labels.select { |label| /2./.match(label) }
      label_versions.join(', ')
    end

    def type
      label_type = @labels.select {|label| /[#{UPDATED_MASK}]||[#{NEW_MASK}]||[#{TECHNICAL_MASK}]/.match(label)}
      case label_type.join
      when /#{UPDATED_MASK}/
        UPDATED_PHRASE
      when /#{NEW_MASK}/
        NEW_PHRASE
      when /#{TECHNICAL_MASK}/
        TECHNICAL_PHRASE
      end    
    end

    def parse_body
      whatsnew_splited = @body.split('whatsnew')[-1]
      newline_splited = whatsnew_splited.split("\n")
      cleaned_array = newline_splited.map { |e| e.delete "\r\*" }
      cleaned_array.delete('')
      striped_array = cleaned_array.map(&:strip)
      striped_array.join("<br/>")
    end

    def description
      return parse_body if @body.include?('whatsnew')
      return "[#{@title}]()"
    end
  end
end
