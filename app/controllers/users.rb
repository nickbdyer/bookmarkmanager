class BookmarkManager

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(:email => params[:email],
                :password => params[:password], 
                :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
    end
  end

  get '/users/forgot_password' do
    erb :"users/forgot_password"
  end

  post '/users/forgot_password' do
    user = User.first(:email => params[:email])
    user.password_token = (1..64).map{[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
    user.password_token_timestamp = Time.now
    user.save
    user.send_simple_message
    flash.now[:notice] = "Password reset email has been sent"
    @links = Link.all
    erb :index 
  end

  get '/users/reset_password/:token' do
    @token = params[:token]
    user = User.first(:password_token => @token)
    if Time.now < user.password_token_timestamp + 3600 
      erb :"users/new_password"
    else
      flash[:notice] = "Password reset request timed out. Please request new link."
      redirect to '/users/forgot_password'
    end
  end

  post '/users/reset_password' do
    user = User.first(:password_token => params[:password_token])
    user.update(password: params[:password], 
                password_confirmation: params[:password_confirmation],
                password_token: nil,
                password_token_timestamp: nil)
    flash.now[:notice] = "Your password has been reset."
    @links = Link.all
    erb :index
  end

end