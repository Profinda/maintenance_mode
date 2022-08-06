require "maintenance_switch/version"
require_relative "maintenance_switch/base"
require_relative "maintenance_switch/rails" if defined?(Rails) && [3,4,5,6].include?(Rails::VERSION::MAJOR)

module MaintenanceSwitch
  class Error < StandardError; end

end
