# frozen_string_literal: true

class Question < ApplicationRecord
  scope :random, -> { order('RANDOM()').first }
  validates :message, presence: true
  belongs_to :user, counter_cache: true
end
