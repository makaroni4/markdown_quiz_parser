require 'redcarpet'
require_relative './parser'
require_relative './markdown'

module MarkdownQuestionParser
  class QuestionProcessor
    def initialize(raw)
      process!(raw)
    end

    def answers
      @renderer.answers
    end

    def paragraphs
      @renderer.paragraphs
    end

    private
    def process!(raw)
      markdown = Redcarpet::Markdown.new(MarkdownQuestionParser::Markdown)
      markdown.render(raw)
      @renderer = markdown.renderer
    end
  end
end
