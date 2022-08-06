require "maintenance_mode/version"
require_relative "maintenance_mode/base"
require_relative "maintenance_mode/rails" if defined?(Rails) && [3,4,5,6].include?(Rails::VERSION::MAJOR)

module MaintenanceMode
  class Error < StandardError; end

end
