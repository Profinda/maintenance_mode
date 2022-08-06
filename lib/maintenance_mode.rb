require "maintenance_swtich/version"
require_relative "maintenance_swtich/base"
require_relative "maintenance_swtich/rails" if defined?(Rails) && [3,4,5,6].include?(Rails::VERSION::MAJOR)

module MaintenanceMode
  class Error < StandardError; end

end
