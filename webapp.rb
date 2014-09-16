require 'sinatra'
require 'haml'
require_relative 'persistence/package_repository.rb'

def repo
  App.new.repo
end

get '/index' do
  @packages = repo.all
  haml :index
end

get '/show/:name' do
  @package = repo.find_by_name(params[:name])
  haml :show
end
