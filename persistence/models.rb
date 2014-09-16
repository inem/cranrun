require 'active_record'
ActiveRecord::Base.establish_connection({:adapter => "sqlite3", :database => 'packages.db'})

class Package < ActiveRecord::Base
  has_many :authors, class_name: "Person"
  has_many :maintainers, class_name: "Person"
end

class Person < ActiveRecord::Base
end