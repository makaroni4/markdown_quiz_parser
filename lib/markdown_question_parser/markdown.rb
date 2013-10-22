module MarkdownQuestionParser

  # After each method nil is returned
  # according to gem 'redcarpet' specification (should return nil or string)
  class Markdown < Redcarpet::Render::HTML
    attr_reader :answers, :paragraphs

    def paragraph(text)
      @paragraphs ||= []
      @paragraphs << text

      nil
    end

    def list(contents, list_type)
      quiz_generator = MarkdownQuestionParser::Parser.new(contents, list_type)
      @answers = quiz_generator.answers if quiz_generator.quiz?

      nil
    end
  end
end
