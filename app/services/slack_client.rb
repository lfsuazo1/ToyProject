# frozen_string_literal: true

# SlackClient.client
module SlackClient
  def client
    Slack::Web::Client.new.tap(&:auth_test)
  rescue Slack::Web::Api::Errors::NotAuthed
    nil
  end

  def post_message
    question = Question.order('RANDOM()').first
    size = Question.count

    if size.positive?
      question.destroy
      payload = {
        channel: '#slack-message-testing',
        blocks: [
          {
            "type": 'section',
            "text": {
              "type": 'mrkdwn',
              "text": 'Time of a topic! :meow_party:'
            }
          },
          {
            "type": 'section',
            "text": {
              "type": 'mrkdwn',
              "text": "\n>  #{question.message}"
            }
          },
          {
            "type": 'context',
            "elements": [
              {
                "type": 'plain_text',
                "text": "Remaining topics in the pool: #{size}",
                "emoji": true
              }
            ]
          }
        ]
      }
      client.chat_postMessage(payload)
    else
      payload2 = {
        channel: '#slack-message-testing',
        blocks: [
          {
            "type": 'section',
            "text": {
              "type": 'mrkdwn',
              "text": 'No more fun today :sadpepe:'
            }
          },
          {
            "type": 'section',
            "text": {
              "type": 'mrkdwn',
              "text": "\n>  Please enter more questions"
            }
          }
        ]
      }
      client.chat_postMessage(payload2)
    end
  end
end
