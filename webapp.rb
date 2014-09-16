require 'sinatra'
require 'haml'
require_relative 'persistence/package_repository.rb'

get '/index' do
  repo = PackageRepository.new
  @packages = repo.all
  haml :index
end

get '/show/:name' do
  repo = PackageRepository.new
  @package = repo.find_by_name(params[:name])
  haml :show
end
