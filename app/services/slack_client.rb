# frozen_string_literal: true

# SlackClient.client
module SlackClient
  def client
    Slack::Web::Client.new.tap(&:auth_test)
  rescue Slack::Web::Api::Errors::NotAuthed
    nil
  end

  def post_message
    slack_message
  end

  def payload_format(title, message, option = { "type": 'divider' })
    payload = {
      channel: ENV['SLACK_CHANNEL'],
      blocks: [
        {
          "type": 'section',
          "text": {
            "type": 'mrkdwn',
            "text": title.to_s
          }
        },
        {
          "type": 'section',
          "text": {
            "type": 'mrkdwn',
            "text": "\n>  #{message}"
          }
        }, option
      ]
    }
  end

  def slack_message
    question = Question.random
    number_of_questions = Question.count
    if number_of_questions.positive?
      question.destroy
      quantity_topics = {
        "type": 'context',
        "elements": [
          {
            "type": 'plain_text',
            "text": "Remaining topics in the pool: #{number_of_questions}"
          }
        ]
      }
      payload = payload_format('Time for a topic! :meow_party:', question.message, quantity_topics)
    else
      payload = payload_format('No more fun today :sadpepe:', 'Please enter more questions')
    end
    client.chat_postMessage(payload)
  end
end
