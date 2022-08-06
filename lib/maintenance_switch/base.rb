# frozen_string_literal: true

require 'redis'

module MaintenanceSwitch
  class Base
    MAINTENANCE_CACHE_KEY = 'MAINTENANCE_KEY'
    DEFAULT_REASON = 'Scheduled maintenance'

    def initialize(app, options = {})
      @app = app
      @options = options
      @redis = Redis.new(url: ENV.fetch('MAINTENANCE_REDIS_URL'))
    end

    def call(env)
      if maintenance_on?
        [503, { 'X-MaintenaceReason' => reason }, [
          "Maintenance Mode ON. Reason: #{reason}. Started at: #{started_at}"
        ]]
      else
        @app.call(env)
      end
    end

    private

    def maintenance_on?
      maintenance_value.present?
    end

    def reason
      maintenance_value['reason']
    end

    def started_at
      maintenance_value['started_at']
    end

    def maintenance_value
      @maintenance_value ||= JSON.parse(@redis.get(MAINTENANCE_CACHE_KEY))
    end
  end
end
