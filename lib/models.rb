require 'virtus'

class Package
  include Virtus.model

  attribute :filename, String
  attribute :name, String
  attribute :version, String

  def to_s
    "#{@filename}: #{@name} #{@version}"
  end

  def url
    "#{App::URL}#{filename}"
  end
end
