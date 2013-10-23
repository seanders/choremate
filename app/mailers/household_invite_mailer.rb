class HouseholdInviteMailer < ActionMailer::Base
  default from: "sean.choremate@gmail.com"

  def send_invite(household, invite)
    @email, @household = invite.email, household
    mail(to: @email, subject: "You've been invited to #{household.name} on Choremate")
  end
end
