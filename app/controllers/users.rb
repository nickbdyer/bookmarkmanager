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

  get '/users/reset_password' do
    erb :"users/reset_password"
  end

  post '/users/reset_password' do
    user = User.first(:email => params[:email])
    user.password_token = (1..64).map{[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
    user.password_token_timestamp = Time.now
    user.save
    flash.now[:notice] = "Password reset email has been sent"
    @links = Link.all
    erb :index 
  end

end