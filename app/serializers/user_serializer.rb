# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  attributes :id, :email, :created_at
  has_many :question
end
