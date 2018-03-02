# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Response.destroy_all
Question.destroy_all
Poll.destroy_all
AnswerChoice.destroy_all
authors = []
usernames = ['tommy', 'bigboy69', '420blazeit', 'codingfornerds', 'chiefkeef']
usernames.each do |username|
  authors << User.create!(username: username)
end

titles = ['Election Polls', 'Patriots Haters Poll', 'International Cannibis Poll']
polls = []
titles.each do |title|
  polls << Poll.create!(title: title, author_id: authors.sample.id)
end

texts = ['Who would you voto for 2020?', 'How much do you hate the Patriots?', 'Where do you like to toke?']

questions = []
texts.each_with_index do |text, idx|
  questions << Question.create!(text: text, poll_id: polls[idx].id)
end

answer_choice_texts = [['Bill Gates', 'Ahnold', 'Kanye West'], ['A lot', 'A little', 'more than anything'], ['My room', 'In public', 'Your moms house']]

answer_choices = []
answer_choice_texts.each_with_index do |set, idx|
  set.each do |text|
    answer_choices << AnswerChoice.create!(answer_text: text, question_id: questions[idx].id)
  end
end


authors.each do |user|
  questions.each do |question|
    Response.create!(user_id: user.id, answer_choice_id: question.answer_choices.sample.id)
  end
end
