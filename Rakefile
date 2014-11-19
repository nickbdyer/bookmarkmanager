require 'data_mapper'
require_relative 'app/models/link'
require_relative 'app/models/tag'
require_relative 'app/models/user'
require './app/data_mapper_setup'

task :auto_upgrade do
  DataMapper.auto_upgrade!
  puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do
  DataMapper.auto_migrate!
  DataMapper.setup(:default, "postgres://localhost/bookmark_manager_test")
  DataMapper.auto_migrate!
  puts "Auto-migrate complete (data could have been lost)"
end
