require 'virtus'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rspec'

class Package
 include Virtus.model

  attribute :name, String
  attribute :version, String

end

class DirParser
  def self.run(contents)
    doc = Nokogiri::HTML(contents)

    doc.css('td a[href]').each do |line|
      regexp = /([^"]*)_(\S*).tar.gz/
      match = regexp.match(line.content).to_a
      unless match.empty?
        yield(match[1], match[2])
      end
    end
  end
end


class App
  def self.run
    url = "http://cran.at.r-project.org/src/contrib/"
    contents = open("./contrib.html").read

    packages = []
    DirParser.run(contents) do |name, version|
      package = Package.new(name: name, version: version)
      packages << package
    end

  end
end

App.run