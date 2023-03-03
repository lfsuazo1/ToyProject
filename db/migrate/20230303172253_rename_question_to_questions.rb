class RenameQuestionToQuestions < ActiveRecord::Migration[7.0]
  def change
    rename_column :questions, :question, :message
  end
end
