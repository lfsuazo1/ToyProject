# frozen_string_literal: true

class SlackJob < ApplicationJob
  include SlackClient
  queue_as :default

  def perform
    post_message
  end
end
