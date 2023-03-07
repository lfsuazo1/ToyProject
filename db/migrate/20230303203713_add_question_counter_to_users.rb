# frozen_string_literal: true

class AddQuestionCounterToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :questions_count, :integer, default: 0, null: false
  end
end
