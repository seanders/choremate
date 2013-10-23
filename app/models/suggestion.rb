class Suggestion < ActiveRecord::Base
  belongs_to :household
  belongs_to :user
  has_many :votes

  validates_presence_of :title, :description, :point_value, :household_id
  validates :description, length: {maximum: 3000}
  validates :point_value, numericality: true

  def turn_into_chore
    chore = household.chores.new(
      title: title,
      description: description,
      point_value: point_value,
    )
    chore.save! if chore.valid?
  end
end
