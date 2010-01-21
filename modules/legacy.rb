# map old url structure to new
get '/coffeerings-articles' do
  redirect "/blog", 301
end
get '/coffeerings-articles/:url' do
  redirect "/blog/#{params[:url]}", 301
end