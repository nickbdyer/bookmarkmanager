class BookmarkManager < Sinatra::Base

  include Helpers

  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :sessions
  set :session_secret, 'super secret'
  set :public_folder, Proc.new { File.join(root, "..", "..", "public") }
  set :views, Proc.new { File.join(root, "..", "views") }
  use Rack::Flash
  use Rack::MethodOverride

  # start the server if ruby file executed directly
  run! if app_file == $0
end