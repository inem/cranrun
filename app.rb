require 'virtus'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'dcf'
require 'tmpdir'

require_relative 'lib/models.rb'
require_relative 'lib/parsers.rb'

class DescExtractor
  def self.run(package)
    Dir.mktmpdir do |dir|
      Dir.chdir dir
      `wget –quiet –output-document output_filename#{package.url}`
      `tar xzf --extract --file=./#{package.filename} #{package.name}/DESCRIPTION`
      a = open("#{package.name}/DESCRIPTION")
    end
  end
end

class App
  URL  = "http://cran.at.r-project.org/src/contrib/"
  attr_accessor :packages

  def initialize(source)
    contents = open(source).read

    @packages = []
    DirParser.run(contents) do |filename, name, version|
      package = Package.new(filename: filename, name: name, version: version)
      @packages << package
      puts package.url
    end

  end
end

App.new("fixtures/contrib.html")


