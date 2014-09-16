require 'virtus'
module Entities
  class Person
    include Virtus.model

    attribute :name, String
    attribute :email, String
  end

  class Package
    include Virtus.model

    attribute :version, String
    attribute :filename, String

    attribute :name, String
    attribute :versions, [String]
    attribute :publication_date, Date
    attribute :title, String
    attribute :description, String
    attribute :authors, [Person]
    attribute :maintainers, [Person]


    def to_s
      "#{@filename}: #{@name} #{@version}"
    end

    def url
      "#{App::URL}#{filename}"
    end
  end
end

