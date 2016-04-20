# Homepage (Root path)
require 'securerandom'
configure do
  enable :sessions
  
get '/' do
  erb :index
end
