# frozen_string_literal: true

require 'rufus-scheduler'

# Inicializa un objeto scheduler
scheduler = Rufus::Scheduler.new

# Agrega una tarea que se ejecute cada miercoles a las 9am
scheduler.cron '0 9 * * 3'  do
  # Envía la tarea a Delayed Job
  MyJob.perform_later
end
