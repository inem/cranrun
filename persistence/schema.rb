require "rubygems"
require "sequel"

DB = Sequel.sqlite("data.db")

DB.create_table :packages do
  primary_key :id
  String :name
  String :version
  DateTime :publication_date
  String :title
  Text :description
end

DB.create_table :people do
  primary_key :id
  String :name
  String :email
end
