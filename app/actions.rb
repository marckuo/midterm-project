# Homepage (Root path)
require 'securerandom'

#this is home page
get '/' do
  erb :index
end

#new user sign-up
#saves - goes to user welcome page
#does not save and reloads with errors listed
post '/new' do
  @user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    username: params[:username],
    password_digest: params[:password_digest],
    email: params[:email],
    phone: params[:phone],
    birthday: params[:birthday],
    profile_pic: params[:profile_pic]
    )
  @user.save
  if @user.save
    redirect '/welcome'
  else
    redirect '/new'
  end
end

#sign-in page
#if username and password if true relocate to welcome page
#false, has login with errors listed
post '/login' do
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
    session[:session_token] = SecureRandom.urlsafe_base64()
    user.update!(session_token: session[:session_token])
    redirect '/welcome'
  else
    redirect '/login'
  end
end

def user_authenticate!
  redirect '/login' unless session.has_key?(:session_token)
  if !session.has_key?(:user_session) || !User.find_by_session_token(session[:session_token])
    redirect '/login'
  end
end

get '/welcome' do
  user_authenticate! 
  erb :welcome
end
