# frozen_string_literal: true

# Action for questions
class QuestionsController < ApplicationController
  def ask; end

  def answer
    @question = params[:question]
    @reponse = generate_reponse(@question)
  end

  private

  def generate_reponse(message)
    if message == 'I am going to work'
      'Great!'
      elsif message.ends_with?('?')
        'Silly question, get dressed and go to work!'
      else
        "I don't care, get dressed and go to work!"
    end
  end
end
