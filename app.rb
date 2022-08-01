require 'sinatra'
require 'sinatra/reloader'
require 'json'

# ------------------ read JSON --------------------
json_file_path = 'data.json'
json_data = open(json_file_path) do |io|
  JSON.load(io)
end
memos = json_data['memos']
# -------------------------------------------------

get '/' do
  @memos = memos
  erb :top
end

get '/top' do
  erb :top
end

get '/hello/:name' do
  "Hello0000 #{params['name']}!"
end
