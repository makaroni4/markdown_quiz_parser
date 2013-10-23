require 'spec_helper'
require_relative '../../lib/markdown_quiz_parser/quiz_detector'

describe MarkdownQuizParser::QuizDetector do
  let(:quiz_detector) { MarkdownQuizParser::QuizDetector.new(text) }

  context 'for check box quiz' do
    let(:text) {
      %{
~~~?
quiz1
~~~


~~~?
quiz2
~~~

* 123
* asdb

      }
    }

    it 'parses quiz question' do
      quiz_detector.questions.should eq(["quiz1\n", "quiz2\n"])
    end
  end

  context 'for list without special symbols for check_box or radio_button' do
    let(:text) {
      %{
* 1
* 2
* [ ] 3
      }
    }

    it 'returns no questions' do
      quiz_detector.questions.should be_nil
    end
  end
end
