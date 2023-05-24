require 'rubygems'
require 'sinatra'
require './lib/pair'
require './lib/url'

get '/' do
  erb :home
end

get '/:short' do
  pair = create_pair(short: params[:short])

  redirect pair.long
end

post '/shorten' do
  if long = URL.valid(params[:url])
    pair = create_pair(long: long)
    content_type :json
    
    { short: URI.join(request.base_url, pair.short), long: pair.long }.to_json
  else
    { error: "URL is not valid." }.to_json
  end
end

def create_pair(url)
  Pair.new(url)
end