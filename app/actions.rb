# Homepage (Root path)
require 'securerandom'
require 'haml'
enable :sessions

#this is home page
get '/' do
  @user = User.find_by_session_token(session[:session_token])
  erb :index
end

get '/login' do
  erb :login
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/signup' do
  erb :'signup'
end

get '/welcome' do
  @user = User.find_by_session_token(session[:session_token])
  erb :'welcome'
end

get '/profilepage' do
  @user = User.find_by_session_token(session[:session_token])
  erb :'profilepage'
end

get "/upload" do
  @user = User.find_by_session_token(session[:session_token])
  haml :upload
end    

get "/create" do
  @user = User.find_by_session_token(session[:session_token])
  erb :'create'
end  

get "/match" do 
  @user = User.find_by_session_token(session[:session_token])
  @sport = Sport.find_by(id: session[:sport_id])
  @matches = @sport.matches.select do |match| 
    match.player_one_id != @user.id && match.player_two_id == nil
  end
  erb :'match'
end

get "/:id" do
  @match = Match.find params[:id]
  erb :'show'
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


post "/upload" do 
  @user = User.find_by_session_token(session[:session_token])
  filename = @user.id.to_s
  filepath = 'public/uploads/'
  if (params['myfile'][:type] == "image/jpg" || params['myfile'][:type] == "image/jpeg" )
    filename += ".jpg"
  elsif  (params['myfile'][:type] == "image/png")
      filename += ".png"
  else
    return "Invalid file"
  end
  File.open(filepath + filename, "w") do |f|
  f.write(params['myfile'][:tempfile].read)
  @user.update!(profile_pic: filename )
  redirect '/profilepage'
  end
end


# def function1 
#   return whether there is an image for the user (boolean)
# end


# def function2
# if @userid

# <% if @user.profile_pic?


#  "/upload.filename.to_i
# # # display picture 
# # else 
# # <h2><a href = "/upload">upload</a></h2>




# welcome to the image 


#welcome page when users sign in
# get '/welcome' do
#   user_authenticate! 
#   erb :welcome
# end


post '/choice' do
  session[:sport_id] = params[:sport_id]
  redirect '/match'
end

post '/new_match' do
  @user = User.find_by_session_token(session[:session_token])
  @match = Match.create(
    sport_id: session[:sport_id],
    address: params[:address],
    player_one_id: @user.id
  )
  redirect '/match'
end

post '/challenge/:id' do 
  @user = User.find_by_session_token(session[:session_token])
  @match = Match.find (params[:id])
  @match.player_two_id = @user.id
  @match.save
  erb :welcome
end

#logout
get '/session/sign_out' do
  User.find_by_session_token(session[:session_token]).update!(session_token: nil)
  session.clear
  redirect '/login'
end
