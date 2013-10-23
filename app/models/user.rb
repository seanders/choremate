class User < ActiveRecord::Base
  has_secure_password
  has_many :households, :through => :household_users
  has_many :household_users
  has_many :votes
  has_many :tasks
  has_many :suggestions

  EMAIL_REGEX = /\A[-a-z0-9~!$%^&*_=+}{'?]+(\.[-a-z0-9~!$%^&*_=+}{'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?\z/i

  validates_presence_of :email, :password_digest, :display_name
  validates :email, uniqueness: true, format: {with: EMAIL_REGEX}

  def create_access_token
    time = 1.day.from_now.to_i
    "#{self.id}.#{time}.#{self.class.hash_access_token(self, time)}"
  end

  def self.find_by_access_token(access_token)
    user_id, time, hash = (access_token||'').split('.')
    return nil if user_id.blank? || time.blank? || hash.blank?
    return nil unless time.to_i > Time.now.to_i
    return nil unless (user = User.find_by_id(user_id))
    return nil unless hash == self.hash_access_token(user, time)
    user
  end

  def self.authenticate(email, password)
    self.find_by_email(email).try(:authenticate, password)
  end

  protected

  def self.hash_access_token(user, time)
    Digest::SHA1.hexdigest("#{user.id}.#{time}inlimbo-everythinginitsrightplace-okComputer-kida-therethere")
  end
end
