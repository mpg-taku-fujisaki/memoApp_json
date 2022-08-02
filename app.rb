require 'sinatra'
require 'sinatra/reloader'
require 'json'

# ------------------ read JSON --------------------
json_file_path = 'data.json'
$json_data = open(json_file_path) do |io|
  JSON.load(io)
end
$memos = $json_data['memos']
# -------------------------------------------------
def find_memo(dist_id)
  dist_memo = ""
  $memos.each do |memo|
    dist_memo = memo if memo['id'] == dist_id
  end 
  return dist_memo
end




# top
get '/memos' do
  @memos = $memos
  erb :top
end


# show
get '/memos/:id/show' do
  # make memos method!!!!!!!
  
  @memo = find_memo(params[:id])
  erb :show
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
  next_id = all_id.max + 1
  
  # make new json-data
  new_data = {
    "id" => next_id.to_s, 
    "title" => params[:title], 
    "content" => params[:content]
  }


  test1 = $json_data, Time.now()
  @test1 = test1

  # add data to json-file
  $json_data['memos'].push(new_data)
  
  @test2 = $json_data


  erb :test
end
