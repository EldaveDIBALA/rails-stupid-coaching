require "application_system_test_case"

class QuestionsTest < ApplicationSystemTestCase
  setup do
    visit ask_url
    assert_selector "h1", text: "Stupid Coaching"
    # Vérifier que la page Ask est affichée
    assert_text "Ask your coach anything:"
  end

  teardown do
    take_screenshot_at_each_step
  end
  test "user can submit a question and receive a response." do
    # Vérifier que le champ de saisie peut être remplie avec la question "I am going to work"
    assert_selector "input[name='question']", visible: true
    fill_in "question", with: "I am going to work"

    # Vérifier que le le bouton Ask est cliquable
    assert_selector "button", text: "Ask", visible: true
    click_on "Ask"

    # Vérifier que l'on est redirigé vers la page Answer
    assert_equal current_url.split('?').first, answer_url

    # Vérifier que la réponse du Coach est conforme
    assert_text "-Your coach"
    assert_text "Great!"
  end

  test "user can submit a wrong question and receive a bad response." do
    # Vérifier que le champ de saisie peut être remplie avec du contenu qui se termine par "?"
    assert_selector "input[name='question']", visible: true
    dynamic_question = generate_dynamic_question
    fill_in "question", with: dynamic_question
    assert page.evaluate_script("document.querySelector('input[name=\"question\"]').value.endsWith('?')"), "The input text does not end with '?'"

    # Vérifier que le le bouton Ask est cliquable
    assert_selector "button", text: "Ask", visible: true
    click_on "Ask"

    # Vérifier que l'on est redirigé vers la page Answer
    assert_equal current_url.split('?').first, answer_url

    # Vérifier que la réponse du Coach est conforme
    assert_text "-Your coach"
    assert_text "Silly question, get dressed and go to work!"
  end

  test "user can submit anything and receive the coach indifference response." do
  #   # Vérifier que le champ de saisie peut être remplie avec n'importe quel contenu
    assert_selector "input[name='question']", visible: true
    dynamic_text = generate_dynamic_text
    fill_in "question", with: dynamic_text

  #   # Vérifier que le le bouton Ask est cliquable
    assert_selector "button", text: "Ask", visible: true
    click_on "Ask"

  #   # Vérifier que l'on est redirigé vers la page Answer
    assert_equal current_url.split('?').first, answer_url

  # #   # Vérifier que la réponse du Coach est conforme
    assert_text "-Your coach"
    assert_text "I don't care, get dressed and go to work!"
  end

  private

  def take_screenshot_at_each_step
    timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    screenshot_path = Rails.root.join("tmp/screenshots/#{timestamp}_screenshot.png")
    page.save_screenshot(screenshot_path)
    puts "Screenshot taken: #{screenshot_path}"
  end

  def generate_dynamic_question
    questions = [
      "What is the meaning of life?",
      "How do I use Ruby on Rails?",
      "Is this the right way to test?",
      "Where is the nearest coffee shop?",
      "Why does the sun rise in the east?"
    ]
    questions.sample
  end

  def generate_dynamic_text
    texts = [
      "Hello Coach!",
      "Lorem ipsum dolor sit amet."
    ]
    texts.sample
  end

# class QuestionsTest < ApplicationSystemTestCase
#   setup do
#     visit ask_url
#     assert_text "Ask your coach anything"
#   end

#   teardown do
#     take_screenshot_at_each_step
#   end

#   test "user can submit a question and receive a response" do
#     submit_question("I am going to work")
#     assert_response_text("Great!")
#   end

#   test "user can submit a wrong question and receive a bad response" do
#     question = generate_dynamic_question
#     assert question.end_with?('?'), "The input text does not end with '?'"
#     submit_question(question)
#     assert_response_text(
#       "Silly question, get dressed and go to work!",
#       "The response text did not match the expected value."
#       )
#   end

#   test "user can submit anything and receive the coach indifference response" do
#     text = generate_dynamic_text
#     submit_question(text)
#     assert_response_text("I don't care, get dressed and go to work!")
#   end

#   private

#   def submit_question(question)
#     fill_in "question", with: question
#     assert_selector "button", text: "Ask", visible: true
#     click_on "Ask"
#     assert_equal current_url.split('?').first, answer_url
#   end

#   def assert_response_text(expected_text)
#     assert_text "-Your coach"
#     actual_text = page.text
#     puts "Actual response text: #{actual_text}"
#     assert_text expected_text
#   end

#   def generate_dynamic_question
#     questions = [
#       "What is the meaning of life?",
#       "How do I use Ruby on Rails?",
#       "Is this the right way to test?",
#       "Where is the nearest coffee shop?",
#       "Why does the sun rise in the east?"
#     ]
#     questions.sample
#   end

#   def generate_dynamic_text
#     texts = [
#       "Hello Coach, what's up?",
#       "Lorem ipsum dolor sit amet"
#     ]
#     texts.sample
#   end

#   def take_screenshot_at_each_step
#     timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
#     screenshot_path = Rails.root.join("tmp/screenshots/#{timestamp}_screenshot.png")
#     page.save_screenshot(screenshot_path)
#     puts "Screenshot taken: #{screenshot_path}"
#   end
end
