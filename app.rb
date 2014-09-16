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
      `wget --quiet  #{package.url}`
      `tar xzf --extract --file=./#{package.filename} #{package.name}/DESCRIPTION`
      text = open("#{package.name}/DESCRIPTION").read

      Dcf.parse(text)
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
    end
  end
end

def extract_people(string)
  people = []
  string.split(/>,?/).each do |part|
    if part.include?("<")
      splitted = part.split("<")

      person = Person.new(name: splitted.first.strip, email: splitted.last.strip)
      puts person.inspect
      people << person
    end

  end
  people
end

def extract_date(string)
  DateTime.strptime(string, '%Y-%m-%d %H:%M:%S')
end


app = App.new("fixtures/contrib.html")

package = app.packages.last
data = DescExtractor.run(package).first

package.attributes = {
        publication_date: extract_date(data["Date/Publication"]),
        title: data["Title"],
        description: data["Description"],
        authors: extract_people(data["Author"]),
        maintainers: extract_people(data["Maintainer"])
      }

puts package.inspect



