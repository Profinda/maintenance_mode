# frozen_string_literal: true

require 'rake'

namespace :maintenance do
  desc 'For setting application in maintenance mode'
  task on: :environment do |task, _args|
    say(task, 'Switching maintenance mode on...')
    reason = ENV.fetch('MAINTENANCE_REASON', MaintenanceSwitch::DEFAULT_REASON)
    say(task, "With a reason: #{reason}")

    redis = Redis.new(url: ENV.fetch('MAINTENANCE_REDIS_URL'))
    redis.set(MaintenanceSwitch::MAINTENANCE_CACHE_KEY, { reason: reason, started_at: Time.now.utc }.to_json)
  end

  task off: :environment do |task, _args|
    say(task, 'Switching maintenance mode off...')

    redis = Redis.new(url: ENV.fetch('MAINTENANCE_REDIS_URL'))
    redis.del(MaintenanceSwitch::MAINTENANCE_CACHE_KEY)
  end
end
