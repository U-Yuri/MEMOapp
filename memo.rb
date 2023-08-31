# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'cgi'

def escape_text(text)
  CGI.escapeHTML(text)
end

def file
  JSON.load_file('public/memos.json')
end

def memo
  memos = file
  @memo = memos[params[:id]]
  [memos, @memo]
end

def write_json(memos)
  File.open('public/memos.json', 'w') do |file|
    JSON.dump(memos, file)
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
  memos, @memo = memo
  num = memos.keys.map(&:to_i)
  next_id = memos.empty? ? 0 : num.max + 1
  memos.store(next_id, { title: escape_text(params[:title]), comment: escape_text(params[:comment]) })
  write_json(memos)
  redirect '/memos'
end

get '/memos/:id' do
  memo
  @id = params[:id]
  erb :show_memo
end

get '/memos/:id/edit_memo' do
  memo
  @id = params[:id]
  erb :edit_memo
end

patch '/memos/:id' do
  memos, @memo = memo
  id = params[:id]
  memos.store(id, { title: escape_text(params[:title]), comment: escape_text(params[:comment]) })
  write_json(memos)
  p memos
  redirect "/memos/#{id}"
end

delete '/memos/:id' do
  memos, @memo = memo
  memos.delete(params[:id])
  write_json(memos)
  redirect '/memos'
end
