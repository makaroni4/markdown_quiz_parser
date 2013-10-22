require 'redcarpet'
require_relative './markdown_question_parser/parser'
require_relative './markdown_question_parser/markdown'

class QuestionDetector
  def initialize(raw)
    detect!(raw)
  end

  def answers
    @renderer.answers
  end

  def paragraphs
    @renderer.paragraphs
  end

  private
  def detect!(raw)
    markdown = Redcarpet::Markdown.new(MarkdownQuestionParser::Markdown)
    markdown.render(raw)
    @renderer = markdown.renderer
  end
end
