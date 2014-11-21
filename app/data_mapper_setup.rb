  env = ENV["RACK_ENV"] || "development"

  # ENV["DATABASE_URL"]

  DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

  DataMapper.finalize
