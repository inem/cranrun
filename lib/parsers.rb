class DirParser
  def self.run(contents)
    doc = Nokogiri::HTML(contents)

    doc.css('td a[href]').each do |line|
      regexp = /([^"]*)_(\S*).tar.gz/
      match = regexp.match(line.content).to_a
      unless match.empty?
        yield(*match)
      end
    end
  end
end
