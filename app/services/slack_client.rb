# frozen_string_literal: true

# SlackClient.client
module SlackClient
  def client
    Slack::Web::Client.new.tap(&:auth_test)
  rescue Slack::Web::Api::Errors::NotAuthed
    nil
  end

  def post_message
    question = Question.random
    slack_message(ENV['SLACK_CHANNEL'],question)
  end

  def slack_message(channel,question)
    number_of_questions = Question.count

    if number_of_questions.positive?
      question.destroy
      payload = {
        channel: channel,
        blocks: [
          {
            "type": 'section',
            "text": {
              "type": 'mrkdwn',
              "text": 'Time for a topic! :meow_party:'
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
                "text": "Remaining topics in the pool: #{number_of_questions}",
                "emoji": true
              }
            ]
          }
        ]
      }
    else
      payload = {
        channel: channel,
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
    end
    client.chat_postMessage(payload)
  end



end
