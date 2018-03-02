class AddColsToAnswerChoices < ActiveRecord::Migration[5.1]
  def change
    add_column :answer_choices, :question_id, :integer, null: false
    add_column :answer_choices, :answer_text, :string, null: false
  end
end
