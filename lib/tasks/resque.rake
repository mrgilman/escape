require "resque/tasks"
require "resque_scheduler/tasks"

task "resque:setup" => :environment do
  require 'resque'
  require 'resque_scheduler'
  require 'resque/scheduler'

  Resque.redis = 'localhost:6379'

  Resque.schedule = YAML.load_file('config/schedule.yml')

end
