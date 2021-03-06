require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql', database: 'hacknews', host: 'localhost'}

class Post < ActiveRecord::Base
has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post
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

# link for new post form
get '/posts/comment/new' do
  erb :comment_new
end

# link for individual posts
get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :post_show
end

# action to create page
post '/posts/create' do
  Post.create(title: params[:title], body: params[:body], link_url: params[:link_url], up_votes: 0, down_votes: 0)
  redirect "/posts"
end

# action to create comment
post '/posts/comment/:id/create' do
 @post = Post.find(params[:id])
 @post.comments.create(author: params[:author], body: params[:body])
  redirect "/posts/#{params[:id]}"
end

# action to update specific page
post '/posts/:id/update' do
 Post.update(params[:id], :body => params[:body], :link_url => params[:link_url], :title => params[:title], :up_votes => params[:up_votes], :down_votes => params[:down_votes])
  redirect "/posts/#{:id}"
end

# add a up vote
post '/posts/:id/upvote' do 
  Post.increment_counter(:up_votes, params[:id])
  # upvotedd = Post.find(params[:id])
  # upvoted[:up_votes] += 1
  # upvoted.save
  redirect "/posts/#{params[:id]}"
end

# add a down vote stay
post '/posts/:id/downvote' do 
  Post.increment_counter(:down_votes, params[:id])
  # upvoted = Post.find(params[:id])
  # upvoted[:down_votes] += 1
  # upvoted.save
  redirect "/posts/#{params[:id]}"
end