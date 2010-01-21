get '/' do
  @posts = Post.all(:limit=>3, :order=>[:created_at.desc])
  erb :index
end

get '/blog' do
  @posts = Post.all(:limit=>options.items_per_page, :order=>[:created_at.desc])
  @page_no = 0
  erb :blog
end

get '/blog/page/:page_no' do
  @posts = Post.all(:limit=>options.items_per_page, :order=>[:created_at.desc], :offset=>options.items_per_page * Integer(params[:page_no]))
  @page_no = Integer(params[:page_no])
  erb :blog
end

get '/blog/:url' do
  posts = Post.all
  @post = Post.first(:url => params[:url])
  erb :blog_post
end

get '/search' do
  @posts = Post.all(:conditions => ['url = ?', 'test'])
  @posts.each do |post|
    puts post.title
  end
end

post '/comment/:id' do
  post = Post.get(params[:id])
  post.comments.new(:posted_by => params[:posted_by],:body => params[:body]).save
  redirect "/blog/#{post.url}"
end

get '/social' do
  erb :social
end