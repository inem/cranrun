require_relative 'models.rb'
require_relative '../lib/entities.rb'

class PackageRepository
  def store(package)
    puts Package.inspect
    record = Package.create!({
      name: package.name,
      version: package.version,
      publication_date: package.publication_date,
      title: package.title,
      description: package.description
    })

    package.authors.each do |author|
      db_person = Person.find_by_email(author.email)
      record.authors << db_person
    end

    package.maintainers.each do |author|
      db_person = Person.find_by_email(author.email)
      record.maintainers << db_person
    end

    record.save!
  end
end