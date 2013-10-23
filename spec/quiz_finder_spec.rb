require 'spec_helper'
require_relative '../lib/quiz_finder'

describe QuizFinder do
  let(:quiz) { QuizFinder.new(text) }

  context 'for check box quiz' do
    let(:text) {
      %{
~~~?
How old is the universe?

* [  ] Was born yesterday
* [  ] ~10M years
~~~
      }
    }

    it 'parses quiz' do
      quiz.quiz.should eq([{:answers=>[{:format=>:check_box, :text=>"Was born yesterday", :right=>false}, {:format=>:check_box, :text=>"~10M years", :right=>false}], :paragraphs=>["How old is the universe?"]}])
    end
  end
end
