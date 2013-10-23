class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :suggestion
  belongs_to :household
  #maybe make a vote belong to house for ease of look up

  # validates_uniqueness_of :user_id, scope: :suggestion_id
  # validates_presence_of :approve, :user_id, :suggestion_id

  validates :user_id, presence: true, uniqueness: { scope: :suggestion_id, message: "can only cast one vote on a suggestion"}
  #make custom validation for boolean value. See to_bool

  after_create do
  #sum up total votes and decide if the chore should be created
    if suggestion.votes.count == household.users.count
      suggestion.approved = true
      suggestion.save!
      suggestion.turn_into_chore
    end
  end

end
