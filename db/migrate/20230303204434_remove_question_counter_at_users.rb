class RemoveQuestionCounterAtUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :questions_counter
  end
end
