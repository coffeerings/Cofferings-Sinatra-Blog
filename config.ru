require 'appengine-rack'
AppEngine::Rack.configure_app(
  :application => 'coffeerings-blog',
  :version => 1)
require 'application'
run Sinatra::Application