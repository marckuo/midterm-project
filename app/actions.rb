# Homepage (Root path)
require 'securerandom'

#this is home page
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

get '/welcome' do
  @user = User.find_by_session_token(session[:session_token])
  erb :welcome
end



def user_authenticate!
  redirect '/login' unless session.has_key?(:session_token)
  if !session.has_key?(:user_session) || !User.find_by_session_token(session[:session_token])
    redirect '/login'
  end
end

#new user sign-up

#saves - goes to user welcome page
#does not save and reloads with errors listed
post '/signup' do
      @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      username: params[:username],
      password: params[:password],
      email: params[:email],
      phone: params[:phone],
      birthday: params[:birthday],
      profile_pic: params[:profile_pic]
      )
      if @user.save
        redirect '/login'
      else
        erb :'/401'
     end   
end


post '/session' do
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
    session[:session_token] = SecureRandom.urlsafe_base64()
    user.update!(session_token: session[:session_token])
    redirect '/welcome'
  else
    redirect '/login'
  end
end



# post '/login' do
#   user = User.find_by_username(params[:username])
#   if user && user.authenticate(params[:password])
#     binding.pry
#     session[:session_token] = SecureRandom.urlsafe_base64()
#     user.update!(session_token: session[:session_token])
#     redirect '/welcome'
# <<<<<<< HEAD
# =======
#       binding.pry
# >>>>>>> 1146fd600235f85b8fc0f2b4b20cf7d551c096b8
#   else
#     redirect '/login'
#   end
# end

#welcome page when users sign in
# get '/welcome' do
#   user_authenticate! 
#   erb :welcome
# end



#logout
get '/session/sign_out' do
  User.find_by_session_token(session[:session_token]).update!(session_token: nil)
  session.clear
  redirect '/login'
end
