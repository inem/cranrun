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

class DescParser
  attr_reader :package
  def initialize(package)
    @package = package
  end

  def update_package!
    fetch_and_extract do |data|
      package.attributes = {
          publication_date: extract_date(data["Date/Publication"]),
          title: data["Title"],
          description: data["Description"],
          authors: extract_people(data["Author"]),
          maintainers: extract_people(data["Maintainer"])
        }
    end
  end

  def fetch_and_extract
    Dir.mktmpdir do |dir|
      Dir.chdir dir
      `wget --quiet  #{package.url}`
      `tar xzf --extract --file=./#{package.filename} #{package.name}/DESCRIPTION`
      text = open("#{package.name}/DESCRIPTION").read

      yield Dcf.parse(text).first
    end
  end

  private
  def extract_people(string)
    people = []
    string.split(/>,?/).each do |part|
      if part.include?("<")
        splitted = part.split("<")

        person = Entities::Person.new(name: splitted.first.strip, email: splitted.last.strip)
        # puts person.inspect
        people << person
      end

    end
    people
  end

  def extract_date(string)
    DateTime.strptime(string, '%Y-%m-%d %H:%M:%S') rescue nil
  end
end