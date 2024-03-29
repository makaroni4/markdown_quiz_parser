require 'spec_helper'
require_relative '../../lib/markdown_question_parser/question_processor'

describe MarkdownQuestionParser::QuestionProcessor do
  let(:question_processor) { MarkdownQuestionParser::QuestionProcessor.new(text) }

  context 'for check box quiz' do
    let(:text) {
      %{
What are vowels?

* [  ] b
* [ x ] a
* [  ] c
* [ x ] e
      }
    }

    it 'parses check_box question list' do
      question_processor.answers.should include({:format=>:check_box, :text=>"b", :right=>false})
      question_processor.answers.should include({:format=>:check_box, :text=>"a", :right=>true})
      question_processor.answers.should include({:format=>:check_box, :text=>"c", :right=>false})
      question_processor.answers.should include({:format=>:check_box, :text=>"e", :right=>true})
      question_processor.paragraphs.should eq(["What are vowels?"])
    end
  end

  context 'for check box quiz' do
    let(:text) {
      %{
What nationality is Matz?

* (  ) Russian
* (  ) France
* (  ) Dutch
* ( x ) Japanese
      }
    }

    it 'parses radio_button question list' do
      question_processor.answers.should include({:format=>:radio_button, :text=>"Russian", :right=>false})
      question_processor.answers.should include({:format=>:radio_button, :text=>"France", :right=>false})
      question_processor.answers.should include({:format=>:radio_button, :text=>"Dutch", :right=>false})
      question_processor.answers.should include({:format=>:radio_button, :text=>"Japanese", :right=>true})
      question_processor.paragraphs.should eq(["What nationality is Matz?"])
    end
  end

  context 'for textfield quiz' do
    let(:text) {
      %{
What is the answer?

42
      }
    }

    it 'parses paragraphs' do
      question_processor.answers.should be_nil
      question_processor.paragraphs.should eq(["What is the answer?", "42"])
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
      question_processor.answers.should be_nil
      question_processor.paragraphs.should be_nil
    end
  end
end
