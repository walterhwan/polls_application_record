class AddPollIdToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :poll_id, :integer, null: false
  end
end
