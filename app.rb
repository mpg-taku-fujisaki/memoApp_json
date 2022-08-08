require 'sinatra'
require 'sinatra/reloader'
require 'json'

# ------------------ read JSON --------------------
json_file_path = 'data.json'
$json_data = open(json_file_path) do |io|
  JSON.load(io)
end
$memos = $json_data['memos']
# ------------------- method ----------------------
def find_memo(dist_id)
  dist_memo = ""
  $memos.each do |memo|
    dist_memo = memo if memo['id'] == dist_id
  end 
  return dist_memo
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end
# "#{h(params[:name])}"

# -------------------- main -----------------------
# top
get '/memos' do
  @memos = $memos
  erb :top
end

# detail
get '/memos/:id/detail' do
  @memo = find_memo(params[:id])
  erb :detail
end

# new
get '/memos/new' do
  erb :new
end

post '/memos/new' do
  # calc next id
  all_id = []
  $memos.each do |memo|
    all_id.push(memo['id'].to_i)
  end
  if all_id.empty?
    next_id = 1
  else
    next_id = all_id.max + 1
  end
  # make new json-data
  new_data = {
    "id" => next_id.to_s, 
    "title" => h(params[:title]), 
    "content" => h(params[:content])
  }
  # add data to json-file
  $json_data['memos'].push(new_data)
  
  redirect '/memos'
end

# edit
get '/memos/:id/edit' do
  @memo = find_memo(params[:id])
  erb :edit
end

patch '/memos/:id/edit' do
  new_memo = {
    "id" => params[:id].to_s, 
    "title" => h(params[:title]), 
    "content" => h(params[:content])
  }
  # edit json-data for update
  $memos.each_with_index do |memo, index|
    if memo['id'].to_s == params[:id].to_s then
      $json_data["memos"][index]["title"] = new_memo["title"]
      $json_data["memos"][index]["content"] = new_memo["content"]
      break
    end 
  end
  # rewrite
  File.open("data.json", 'w') do |file|
    JSON.dump($json_data, file)
  end
  
  redirect '/memos'
end

# delete
delete '/memos/:id/delete' do
  $memos.each_with_index do |memo, index|
    if memo['id'].to_s == params[:id].to_s then
      $json_data["memos"].delete_at(index)
      break
    end 
  end
  # rewrite
  File.open("data.json", 'w') do |file|
    JSON.dump($json_data, file)
  end

  redirect '/memos'
end
