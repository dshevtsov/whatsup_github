# frozen_string_literal: true

module WhatsupGithub
  # Row to be converted to entry in future table
  class Row
    attr_reader :body,
                :title,
                :labels,
                :link,
                :pr_number,
                :assignee,
                :author,
                :author_url,
                :merge_commit,
                :is_private

    def initialize(args)
      @repo = args[:repo]
      @repo_url = args[:repo_url]
      @is_private = args[:private]
      @title = args[:pr_title]
      @body = args[:pr_body]
      @date = args[:date]
      @labels = args[:pr_labels]
      @assignee = args[:assignee]
      @author = args[:author]
      @author_url = args[:author_url]
      @pr_number = args[:pr_number]
      @link = args[:pr_url]
      @merge_commit = args[:merge_commit_sha]
      @config = Config.instance
    end

    def labels_from_config
      @config.labels
    end

    def required_labels
      @config.required_labels
    end

    def magic_word
      @config.magic_word
    end

    def versions
      label_versions = labels.select { |label| label.start_with?(/\d\./) }
      label_versions.join(', ')
    end

    def date
      @date.strftime('%B %-e, %Y')
    end

    def type
      (labels & labels_from_config).join(', ')
    end

    def parse_body
      # Split PR description in two parts by 'magic word', and take the second half
      description_splited = body.split(magic_word)[-1]
      # Convert new line separators to <br> tags
      newline_splited = description_splited.split("\n")
      cleaned_array = newline_splited.map { |e| e.delete "\r\*" }
      cleaned_array.delete('')
      striped_array = cleaned_array.map(&:strip)
      striped_array.join('<br/>')
    end

    def description
      # If a PR body includes a phrase 'whatsnew', then parse the body.
      # If there are at least one required label but PR body does not include what's new, warn about missing 'whatsnew'
      if body.include?(magic_word)
        parse_body
      else
        message = "MISSING #{magic_word} in the #{type} PR \##{pr_number}: \"#{title}\" assigned to #{assignee} (#{link})"
        puts message
        message
      end
    end
  end
end
