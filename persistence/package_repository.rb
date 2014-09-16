require_relative '../lib/entities.rb'
require 'ostruct'

require 'mongo'
include Mongo

class PackageRepository
  attr_accessor :collection

  def initialize(collection)
    mongo = MongoClient.new
    db = mongo["packages_db"]
    @collection = db[collection]
  end

  def store_new(package)
    @collection.insert({
      name: package.name,
      versions: [package.version],
      publication_date: to_time(package.publication_date),
      title: package.title,
      description: package.description,
      authors: people(package.authors),
      maintainers: people(package.maintainers)
    })
  end

  #doesnt work
  def add_version(package, version)
    stored_package = get_package(@collection.find(name: package.name).first)
    versions = stored_package.versions + Array(version)
    @collection.find(name: package.name).update(versions)
  end

  def all
    @collection.find.map do |data|
      get_package(data)
    end
  end

  def find_by_name(name)
    get_package(@collection.find(name: name).first)
  end

  private

  def get_package(package_data)
    if package_data
      data = OpenStruct.new(package_data)
      Entities::Package.new({
        name: data.name,
        versions: data.versions,
        publication_date: data.publication_date,
        title: data.title,
        description: data.description,
        authors: get_people(data.authors),
        maintainers: get_people(data.maintainers)
      })
    end
  end


  def get_people(people_data)
    people_data.map do |p|
      Entities::Person.new(name: p["name"], email: p["email"])
    end
  end

  def people(ppl)
    ppl.map do |p|
      {email: p.email, name: p.name}
    end
  end

  def to_time(date)
    date.to_time.utc if date
  end
end