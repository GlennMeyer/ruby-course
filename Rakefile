require 'active_record_tasks'
require_relative 'server.rb'

ActiveRecordTasks.configure do |config|
  config.db_dir = 'db'
  config.db_config_path = 'db/config.yml'
  config.env = 'dev'
end

ActiveRecordTasks.load_tasks