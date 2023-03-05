class Question < ApplicationRecord
  validates :message, presence: true
  belongs_to :user, counter_cache: true
end
