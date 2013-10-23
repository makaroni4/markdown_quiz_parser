module MarkdownQuizParser

  # After each method nil is returned
  # according to gem 'redcarpet' specification (should return nil or string)
  class Markdown < Redcarpet::Render::HTML
    attr_reader :questions

    QUESTION_LANGUAGE = "?"

    def block_code(code, language)
      @questions ||= []
      @questions << code if language == QUESTION_LANGUAGE

      nil
    end
  end
end
