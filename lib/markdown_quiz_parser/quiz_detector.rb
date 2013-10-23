require 'redcarpet'
require_relative './markdown'

module MarkdownQuizParser
  class QuizDetector
    def initialize(raw)
      process!(raw)
    end

    def questions
      @renderer.questions
    end

    private
    def process!(raw)
      markdown = Redcarpet::Markdown.new(MarkdownQuizParser::Markdown, fenced_code_blocks: true)
      markdown.render(raw)
      @renderer = markdown.renderer
    end
  end
end
