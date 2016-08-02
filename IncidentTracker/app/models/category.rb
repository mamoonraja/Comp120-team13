class Category < ActiveRecord::Base
  has_and_belongs_to_many :departments
  has_and_belongs_to_many :incidents
end
