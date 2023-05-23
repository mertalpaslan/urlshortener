require 'sinatra'

get '/' do
  erb :home
end

post '/shorten' do
  @url = db.find_or_init(params[:url])
  params[:url]
end