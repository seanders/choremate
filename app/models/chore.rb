class Chore < ActiveRecord::Base
  belongs_to :household
  has_many :tasks

  validates_presence_of :title, :description, :point_value, :household_id
  validates :description, length: {maximum: 3000}
  validates :point_value, numericality: true

end
