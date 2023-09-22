# Create Access Profiles
AccessProfile.create!(Friendly_Name: "Admin", Department: "Administration", Title: "Administrator", IsAdmin: true)
AccessProfile.create!(Friendly_Name: "DON", Department: "Administration", Title: "Director of Nursing", IsAdmin: false)
10.times do
  t = Faker::Job.title
  AccessProfile.create!(Friendly_Name: t, Department: Faker::Job.field, Title: t, IsAdmin: Faker::Boolean.boolean)
end

# Create Facilities
15.times do
  Facility.create!(id: Faker::Number.unique.number(digits: 3), Report_Name: Faker::Company.name, Discipline: (Faker::Boolean.boolean ? "ALF" : "SNF"), Phone: Faker::Number.number(digits: 10), Fax: Faker::Number.number(digits: 10), Address1: Faker::Address.street_address, City: Faker::Address.city, State: Faker::Address.state_abbr, Zip: Faker::Address.zip_code)
end
Facility.create(id: 4, Report_Name: "The Atriums", Discipline: "ALF", Phone: "9999999999", Fax: "9999999999", Address1: "1234 Main St", City: "Overland Park", State: "KS", Zip: "66212")
Facility.create(id: 337, Report_Name: "Mission Chateau", Discipline: "ALF", Phone: "3373373337", Fax: "3373373377", Address1: "337 Main St", City: "Overland Park", State: "KS", Zip: "66212")

15.times do
  User.create!(User_Name: Faker::Internet.username, Full_Name: Faker::Name.name, Email_Address: Faker::Internet.email, password: "6988", password_confirmation: "6988")
end

# Create Users
User.create(User_Name: "admin", password: "admin", password_confirmation: "admin", Full_Name: "Administrator")
User.create!(User_Name: "DylanH", Full_Name: "Dylan Hays", Email_Address: "twentygx@outlook.com", password: "6988", password_confirmation: "6988",
  Access_Until: "2021-12-31", Phone: "999-999-9999", Extension: 135, Credentials: "none")

# Create FacilityAccesses for Admin and DylanH
Facility.all.each do |f|
  FacilityAccess.create(user_id: "16", facility_id: f.id, profile: 1)
  @access = FacilityAccess.create(user_id: "17", facility_id: f.id, profile: 1)
end

# Create i FacilityAccesses for random users
i = 25
i.times do
  while !@access.new_record? || i == 25
    @access = FacilityAccess.find_or_initialize_by(user_id: User.where("id < ?", 16).all.sample.id, facility_id: Facility.all.sample.id)
    if @access.new_record?
      @access.profile = AccessProfile.all.sample.id
      @access.save!
      i -= 1
      break
    else
      puts "Attempted to create repeat FacilityAccess. #{i} remaining."
    end
  end
end
