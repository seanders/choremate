class HouseholdInvite < ActiveRecord::Base
  belongs_to :household

  validates_uniqueness_of :email, scope: :household_id
  validates_presence_of :household_id, :token, :email
  EMAIL_REGEX = /\A[-a-z0-9~!$%^&*_=+}{'?]+(\.[-a-z0-9~!$%^&*_=+}{'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?\z/i
  validates :email, format: {with: EMAIL_REGEX, on: :create}


  before_create do
    self.token = self.class.generate_token(household)
  end

  def self.generate_token(household)
    time = Time.now.to_i
    hash = create_token_hash(household.id, time)
    "#{household.id}.#{time}.#{hash}"
  end

  def self.token_valid?(token)
    #token is valid if time, household_id, and hash match
    household_id, time, hash = token.split('.')
    household = Household.where(id: household_id).first #use where vs. find so we can have NIL value
    return false unless household
    return false unless hash == create_token_hash(household_id, time)
    return true
  end

  def accept!(user)
    if self.class.token_valid?(token)
      household.users << user
      self.destroy
    else
      return false
    end
  end

  def reject!
    self.destroy
  end

  protected

  def self.create_token_hash(household_id, time)
    Digest::MD5.hexdigest("#{household_id}.#{time}.many-wow-such-shibe-doge-seanders-NOPE")
  end

end
