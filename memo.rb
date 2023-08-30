require 'sinatra'
require 'json'
require 'debug'

def file
  File.open("public/memos.json") do |f|
  	JSON.load(f)
  end
end

get '/' do
    redirect '/memos'
end

get '/memos' do
	@memos = file
	erb :index
end

get '/memos/new_memo' do
  erb :new_memo
end

post '/memos/new_memo/add_new' do
  memos = file
	@memo = memos[params[:id]]
  num = memos.keys.map{|id| id.to_i}
  if memos.empty?
    next_id = 0
  else
    next_id = num.max + 1
  end
  memos.store(next_id, {title: params[:title], comment: params[:comment]})
  File.open("public/memos.json", "w") do |file|
    JSON.dump(memos, file)
  end
  redirect '/memos'
end

get '/memos/:id' do
	memos = file
	@memo = memos[params[:id]]
  @id = params[:id]
  erb :show_memo
end

get '/memos/:id/edit_memo' do
  memos = file
	@memo = memos[params[:id]]
  @id = params[:id]
  erb :edit_memo
end

patch '/memos/:id' do
  memos = file
	@memo = memos[params[:id]]
  id = params[:id]
  memos.store(id, {title: params[:title], comment: params[:comment]})
  File.open("public/memos.json", "w") do |file|
    JSON.dump(memos, file)
  end
  p memos
  redirect "/memos/#{id}"
end

delete '/memos/:id' do
  memos = file
	@memo = memos[params[:id]]
  memos.delete(params[:id])
  File.open("public/memos.json", "w") do |file|
    JSON.dump(memos, file)
  end
  redirect '/memos'
end
