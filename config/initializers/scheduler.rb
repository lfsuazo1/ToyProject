# frozen_string_literal: true

require 'rufus-scheduler'

# Initializes a scheduler object
scheduler = Rufus::Scheduler.new

# scheduler.cron '1 5 * * 3'  do ENV['TIMING_MESSAGE']

scheduler.cron '00 15 * * 3' do
  SlackJob.perform_later
end



