
#test users
sean = User.create(first_name: "Sean", last_name: "Miller", email: "slicebo123@gmail.com", password: "inlimbo1", display_name: "slicebo123")
ray = User.create(first_name: "Raymond", last_name: "Ryan", email: "boojala@gmail.com", password: "password", display_name: "boojala")
robert = User.create(first_name: "Robert", last_name: "Tran", email: "robertduncantran@gmail.com", password: "password", display_name: "assjackhammer")
sam = User.create(first_name: "Sam", last_name: "Blanchard", email: "nonphotofortress@gmail.com", password: "password", display_name: "sblanchard")
users = [sean, ray, robert, sam]

# create household and put all users in that household
home = Household.create(name: "La Casa De Pojitos")
users.each {|user| home.users << user}

#create some dummy chores
dishes = Chore.new(
    title:       "Dishes",
    description: "Completed one full load of dishes. Enough to fill up drying rack or approx. 1/3 to 1/4 of dishwasher",
    point_value: 5
  )


cook_dinner = Chore.new(
    title:       "Cook Dinner",
    description: "Cook a complete meal",
    point_value: 5
  )

dispose_trash = Chore.new(
    title:       "Take out trash",
    description: "Take out a full bag of garbage",
    point_value: 2
  )

dispose_recycling = Chore.new(
    title:       "Take out recycling",
    description: "Take out a full bag of recycling",
    point_value: 2
  )
chores = [dishes, cook_dinner, dispose_trash, dispose_recycling]
chores.each {|chore| home.chores << chore; chore.save}
