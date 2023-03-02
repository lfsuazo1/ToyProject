# frozen_string_literal: true

Slack.configure do |config|
  config.token = ENV['SLACK_TOKEN']
end
# client.chat_postMessage(channel: 'slack-message-testing', text: 'Hello Herbert', as_user: true)
