module MarkdownQuizParser

  # After each method nil is returned
  # according to gem 'redcarpet' specification (should return nil or string)
  class Markdown < Redcarpet::Render::HTML
    attr_reader :questinos

    QUESTION_LANGUAGE = "?"

    def block_code(text, language)
      @questinos ||= []
      @questinos << text if language == QUESTION_LANGUAGE

      nil
    end
  end
end
