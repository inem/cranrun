require "rubygems"
require 'virtus'
require 'pry'
require 'sqlite3'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'dcf'
require 'tmpdir'

require_relative 'persistence/models.rb'
require_relative 'persistence/package_repository.rb'
require_relative 'lib/entities.rb'
require_relative 'lib/parsers.rb'


class App
  URL  = "http://cran.at.r-project.org/src/contrib/"
  attr_accessor :packages

  def first_run(source)
    contents = open(source).read

    @packages = []
    DirParser.run(contents) do |filename, name, version|
      package = Entities::Package.new(filename: filename, name: name, version: version)
      @packages << package
      DescParser.new(package).update_package!

      repo = PackageRepository.new
      repo.store_new(package)
    end
  end

  def update(source)
    contents = open(source).read
    repo = PackageRepository.new

    @packages = []
    DirParser.run(contents) do |filename, name, version|
      package = repo.find_by_name(name)
      if package
        unless package.versions.include?(version)
          puts "new version!! #{name} #{version}"
          repo.add_version(package, version)
        end
      else
        puts "new package!!: #{name}"
        package = Entities::Package.new(filename: filename, name: name, version: version)
        repo.store_new(package)
      end
    end
  end
end
