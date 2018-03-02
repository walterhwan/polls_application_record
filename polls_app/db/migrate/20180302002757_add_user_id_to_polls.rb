class AddUserIdToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :author_id, :integer, null: false
  end
end
