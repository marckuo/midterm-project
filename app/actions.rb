# Homepage (Root path)
require 'securerandom'

#this is home page
get '/' do
  erb :index
end

#new user sign-up
#saves - goes to user welcome page
#does not save - reloads
post '/new' do
  @user = User.create(
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

