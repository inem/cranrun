require 'virtus'
require 'nokogiri'
require 'open-uri'

class Package
 include Virtus.model

  attribute :name, String
  attribute :version, String

end

class DirParser
  def self.run(url)
    doc = Nokogiri::HTML(open(url))

    # doc.css('h3.r a').each do |link|
      # puts link.content
    # end
  end
end

DirParser.run("http://cran.at.r-project.org/src/contrib/")

