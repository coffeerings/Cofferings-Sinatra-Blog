get '/admin' do
  protected!
  @post = Post.new
  erb :admin
end

post '/admin' do
  protected!
  post = Post.create(params)
  redirect "/admin/#{post.url}"
end

get '/admin/:url' do
  protected!
  @post = Post.first(:url => params[:url])
  erb :admin
end

post '/admin/:url' do
  protected!
  post = Post.first(:url => params[:url])
  post.update(params)
  redirect "/admin/#{post.url}"
end