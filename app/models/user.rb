# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: { message: 'The email field cannot be empty' },
                    uniqueness: { message: 'Email is already in use' }
  scope :top_five_users, -> { order('questions_count DESC').limit(5) }

  validates :password, presence: { message: 'The password field cannot be empty' },
                       length: { minimum: 6, message: 'The password must be at least 6 characters long' }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :question
end
