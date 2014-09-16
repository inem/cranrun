require "rubygems"
require 'virtus'
require 'pry'
require 'sqlite3'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'dcf'
require 'tmpdir'

require_relative 'persistence/models.rb'
require_relative 'persistence/package_repository.rb'
require_relative 'lib/entities.rb'
require_relative 'lib/parsers.rb'


class App
  URL  = "http://cran.at.r-project.org/src/contrib/"
  attr_accessor :packages

  def initialize(source)
    contents = open(source).read

    @packages = []
    DirParser.run(contents) do |filename, name, version|
      package = Entities::Package.new(filename: filename, name: name, version: version)
      @packages << package
      DescParser.new(package).update_package!
      # puts package.name, package.authors.inspect, package.maintainers.inspect, ""

      repo = PackageRepository.new
      repo.store_new(package)
    end
  end
end



