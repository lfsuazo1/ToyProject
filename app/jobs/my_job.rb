# frozen_string_literal: true

class MyJob < ApplicationJob
  include SlackClient
  queue_as :default

  def perform
    post_message
  end
end
