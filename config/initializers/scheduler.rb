# frozen_string_literal: true

require 'rufus-scheduler'

# Initializes a scheduler object
scheduler = Rufus::Scheduler.new

# scheduler.cron '0 9 * * 3'  do
scheduler.every ENV['TIMING_MESSAGE'] do
  SlackJob.perform_later
end
