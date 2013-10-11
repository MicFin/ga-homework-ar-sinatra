require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql', database: 'hacknews', host: 'localhost'}

class Post < ActiveRecord::Base
end

# link for main page
get '/posts' do
  @posts = Post.all
  erb :post_index
end

# link to edit specific page
get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  erb :post_edit
end

# action to delete specific post
post '/posts/:id/delete' do 
 Post.find(params[:id]).delete
  redirect '/posts'
end

# link for new post form
get '/posts/new' do
  erb :post_new
end

# link for individual posts
get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :post_show
end

# action to create page
post '/posts/create' do
  Post.create(title: params[:title], body: params[:body], link_url: params[:link_url], up_votes: params[:up_votes], down_votes: params[:down_votes])
  redirect "/posts"
end


# action to update specific page
post '/posts/:id/update' do
 Post.update(params[:id], :body => params[:body], :link_url => params[:link_url], :title => params[:title], :up_votes => params[:up_votes], :down_votes => params[:down_votes])
  redirect "/posts"
end