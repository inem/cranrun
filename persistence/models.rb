require 'active_record'

class Package < ActiveRecord::Base
  has_many :authors, class_name: "Person"
  has_many :maintainers, class_name: "Person"
end

class Person < ActiveRecord::Base
end
