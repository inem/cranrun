# require 'active_record'

# class Package < Sequel::Model
#   one_to_many :authors,
#   one_to_many :maintainers,
# end

# class Package < ActiveRecord::Base
#   one_to_many :tracks
#   has_many :authors, class_name: "Person"
#   has_many :maintainers, class_name: "Person"
# end

# class Person < ActiveRecord::Base
# end
