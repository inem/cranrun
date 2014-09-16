require "rubygems"
require 'virtus'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'dcf'
require 'tmpdir'

require_relative 'persistence/models.rb'
require_relative 'lib/entities.rb'
require_relative 'lib/parsers.rb'

class App
  URL  = "http://cran.at.r-project.org/src/contrib/"
  attr_accessor :packages

  def initialize(source)
    contents = open(source).read

    @packages = []
    DirParser.run(contents) do |filename, name, version|
      package = Package.new(filename: filename, name: name, version: version)
      @packages << package
    end
  end
end


app = App.new("fixtures/contrib.html")


app.packages.each do |package|
  desc_parser = DescParser.new(package)
  desc_parser.update_package!
  puts package.name, package.authors.inspect, package.maintainers.inspect, ""

end

