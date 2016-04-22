# Homepage (Root path)
require 'securerandom'
require 'haml'

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

get '/profilepage' do
  @user = User.find_by_session_token(session[:session_token])
  erb :profilepage
end

get "/upload" do
  @user = User.find_by_session_token(session[:session_token])
  haml :upload
end    

get "/create" do
  @user = User.find_by_session_token(session[:session_token])
  erb :create
end  

get "/match" do 
  # debugger, '@sport_id'
  @user = User.find_by_session_token(session[:session_token])
  erb :match
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
  return "The file was successfully uploaded!"
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
  @sports_id = params[:sport_id]
  # specific sport, save to user before redirecting
  # debugger, check what '@sports_id'
  # table for managing multiple pages/sports for a user
  # attach sport id to session (temporarily)
  # remove after match created
  # temporary playing with, 
  redirect '/match'
end

post '/new_match' do
 @user = User.find_by_session_token(session[:session_token])
 @match = Match.create(
   # sport_id: params[:sport_id].to_i,
   player_one_id: @user.id
 )
end

end

#logout
get '/session/sign_out' do
  User.find_by_session_token(session[:session_token]).update!(session_token: nil)
  session.clear
  redirect '/login'
end
