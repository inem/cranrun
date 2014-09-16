require_relative 'models.rb'
require_relative '../lib/entities.rb'

require 'mongo'
include Mongo

class PackageRepository
  def initialize
    mongo = MongoClient.new
    db = mongo["packages_db"]
    @collection = db["packages"]
    # @people_collection = db["people"]
  end

  def store(package)
    @collection.insert({
      name: package.name,
      version: package.version,
      publication_date: to_time(package.publication_date),
      title: package.title,
      description: package.description,
      authors: people(package.authors),
      maintainers: people(package.maintainers)
    })
  end

  def get_by_name(name)
    @collection.find(name: name)
  end

  private

  def people(ppl)
    ppl.map do |p|
      {email: p.email, name: p.name}
    end
  end

  def to_time(date)
    date.to_time.utc if date
  end
end