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

    res = []
    doc.css('td a[href]').each do |line|
      puts line.content

      regexp = /([^"]*)_(\S*).tar.gz/
      match = regexp.match(line.content).to_a
      res << [match[1], match[2]]

    end
    res
  end
end


class App
  def self.run
    url = "http://cran.at.r-project.org/src/contrib/"
    contents = open(url).read

    DirParser.run(contents)
  end
end

App.run