get '/' do
  @user = User.find(session[:id]) if logged_in?
  @all_posts = Post.all
  
  erb :index
end

get 'log_sign' do
  erb :log_sign
end

######################## USER STUFF ########################

post '/sign_up' do ##a real gem
  @user = User.create(params[:user])
  if @user.valid?
    session[:id] = @user.id
    @last_page = session[:referrer]
    redirect "#{@last_page}"
    session[:referrer] = nil
  else
    @errors = @user.errors.full_messages.join(", ")
    erb :log_sign
  end
end

post '/log_in' do
  @user = User.find_by_name(params[:user][:name])
  if @user
    if @user.password == params[:user][:password]
      session[:id] = @user.id
      @last_page = session[:referrer]
      redirect "#{@last_page}"
      session[:referrer] = nil
    else
      @error = "Login error: Invalid password"
      erb :log_sign
    end
  else
    @error = "Login error: Invalid name"
    erb :log_sign
  end
end

get '/log_out' do
  session.clear
  redirect '/'
end

get '/users/:name' do
  @user = User.find_by_name(params[:name])
  erb :user_profile
end

######################## POST STUFF ########################

get '/posts/:id' do
  @post = Post.find(params[:id])
  @all_comments = Comment.where("post_id = ?", @post.id)
  erb :post_comments
end

######################## COMMENT STUFF ########################

post '/new_comment' do
  @comment = Comment.create(params)
end


