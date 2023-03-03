# frozen_string_literal: true

class QuestionSerializer
  include FastJsonapi::ObjectSerializer
  set_type :question
  attributes :id, :message, :created_at, :updated_at
  belongs_to :user
end
