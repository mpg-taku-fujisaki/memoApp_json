require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/' do
  content_type :json
  data = { foo: "bar" }
  data.to_json
end

get '/top' do
  erb :top
end

get '/hello/:name' do
  "Hello0000 #{params['name']}!"
end
