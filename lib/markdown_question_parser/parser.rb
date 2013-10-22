module MarkdownQuestionParser
  class Parser
    CHOISE_REGEXP = /\A<li>(\(|\[)(\sx\s|\s\s)(\)|\])\s/
    BACKWARD_LI = /<\/li>\z/

    def initialize(contents, list_type)
      @contents = contents
    end

    def quiz?
      @contents.split("\n").each do |list_item|
        return false unless list_item =~ CHOISE_REGEXP
      end

      true
    end

    def answers
      @contents.split("\n").inject([]) do |answers, list_item|
        answer = {
          format: answer_format(list_item),
          text: list_item.gsub(CHOISE_REGEXP, '').gsub(BACKWARD_LI, ''),
          right: answer_right(list_item),
        }
        answers << answer
      end
    end

    private
    def answer_format(list_item)
      match_data = list_item.scan(CHOISE_REGEXP).first
      if match_data[0] == "(" && match_data[2] == ")"
        :radio_button
      elsif match_data[0] == "[" && match_data[2] == "]"
        :check_box
      end
    end

    def answer_right(list_item)
      match_data = list_item.scan(CHOISE_REGEXP).first
      case match_data[1]
      when " x "
        true
      when "  "
        false
      end
    end
  end
end
