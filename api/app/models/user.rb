class User
  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :githuh_username, type: String
  field :followers, type: String
  field :following, type: String
  field :stars, type: String
  field :last_year_contributions, type: String
  field :image_url, type: String
  field :organization, type: String
  field :location, type: String
  field :creation_date, type: DateTime, default: DateTime.current
end
