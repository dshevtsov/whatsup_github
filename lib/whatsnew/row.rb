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

    def versions
      label_versions = @labels.select { |label| /2./.match(label) }
      label_versions.join(', ')
    end

    def type
      updated_mask = 'update'
      updated_phrase = 'Updated'
      new_mask = 'New'
      new_phrase = 'New'
      label_type = @labels.select {|label| /[#{updated_mask}]||[#{new_mask}]/.match(label)}
      case label_type.join
      when /#{updated_mask}/
        updated_phrase
      when /#{new_mask}/
        new_phrase
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
