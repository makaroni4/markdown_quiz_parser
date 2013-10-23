require_relative './markdown_question_parser/question_processor'
require_relative './markdown_quiz_parser/quiz_detector'

class QuizFinder
  attr_reader :quiz

  def initialize(text)
    parse_quiz!(text)
  end

  private
  def parse_quiz!(text)
    quiz_detector = MarkdownQuizParser::QuizDetector.new(text)
    if quiz_detector.questions
      @quiz ||= quiz_detector.questions.inject({}) do |quiz, question|
        question_processor = MarkdownQuestionParser::QuestionProcessor.new(question)
        quiz[:questions] ||= []
        quiz[:questions] << {
          answers: question_processor.answers,
          paragraphs: question_processor.paragraphs
        }
      end
    end
  end
end
