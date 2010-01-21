require 'sinatra'
require 'dm-core'

# Google App Engine datastore 
DataMapper.setup(:default, "appengine://auto")

class Post
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :intro, Text
  property :content, Text
  property :url, String
  property :created_at, DateTime
  
  has n, :comments
end

class Comment
  include DataMapper::Resource

  property :id, Serial
  property :posted_by, String
  property :body, Text
  
  belongs_to :post
end

class Contact
  include DataMapper::Resource
  
  property :id, Serial
  property  :email, String
  property  :name, String
  property  :content, Text
end

helpers do
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="HTTP Auth")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
  end
  
  def partial(name, options = {})
    erb("_#{name.to_s}".to_sym, options.merge(:layout => false))
  end
end


set :items_per_page, 5

load 'modules/blog.rb'
load 'modules/admin.rb'
load 'modules/legacy.rb'