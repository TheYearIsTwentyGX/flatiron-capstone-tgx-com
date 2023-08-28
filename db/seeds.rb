# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

AccessProfile.create!(Friendly_Name: "Admin", Department: "Administration", Title: "Administrator", IsAdmin: true)
AccessProfile.create!(Friendly_Name: "DON", Department: "Administration", Title: "Director of Nursing", IsAdmin: false)
10.times do
  t = Faker::Job.title
  AccessProfile.create!(Friendly_Name: t, Department: Faker::Job.field, Title: t, IsAdmin: Faker::Boolean.boolean)
end

15.times do
  Facility.create!(id: Faker::Number.unique.number(digits: 3), Report_Name: Faker::Company.name, Discipline: (Faker::Boolean.boolean ? "ALF" : "SNF"), Phone: Faker::Number.number(digits: 10), Fax: Faker::Number.number(digits: 10), Address1: Faker::Address.street_address, City: Faker::Address.city, State: Faker::Address.state_abbr, Zip: Faker::Address.zip_code)
end
User.create(User_Name: "admin", password: "admin", password_confirmation: "admin", Access_Profile: 1, Full_Name: "Administrator")
User.create!(User_Name: "DylanH", Full_Name: "Dylan Hays", Email_Address: "twentygx@outlook.com", password: "6988", password_confirmation: "6988",
  Access_Profile: 2, Access_Until: "2021-12-31", Phone: "999-999-9999", Extension: 135, Credentials: "none")

15.times do
  User.create!(Access_Profile: Faker::Number.between(from: 1, to: 12), User_Name: Faker::Internet.username, Full_Name: Faker::Name.name, Email_Address: Faker::Internet.email, password: "6988", password_confirmation: "6988")
end
Facility.create!(id: 4, Report_Name: "The Atriums", Discipline: "ALF", Phone: "9999999999", Fax: "9999999999", Address1: "1234 Main St", City: "Overland Park", State: "KS", Zip: "66212")
Facility.create!(id: 337, Report_Name: "Mission Chateau", Discipline: "ALF", Phone: "3373373337", Fax: "3373373377", Address1: "337 Main St", City: "Overland Park", State: "KS", Zip: "66212")

Facility.all.each do |f|
  FacilityAccess.create(user_id: "1", facility_id: f.id, Access_Until: "2024-12-31")
  FacilityAccess.create(user_id: "2", facility_id: f.id, Access_Until: "2024-12-31")
end

25.times do
  FacilityAccess.create(user_id: User.all.sample.User_Name, facility_id: Facility.all.sample.id, Access_Until: "2024-12-31")
end
