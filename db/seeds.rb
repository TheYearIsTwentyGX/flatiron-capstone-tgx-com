# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(User_Name: "DylanH", Full_Name: "Dylan Hays", Email_Address:"twentygx@outlook.com", password: "6988", password_confirmation: "6988",
Access_Profile: 2, Access_Until: "2021-12-31", Phone: "999-999-9999", Extension: 135)
Facility.create!(Coserial: 4, Report_Name: "The Atriums", Discipline: "ALF", Phone: "999-999-9999", Fax: "999-999-9999", Address1: "1234 Main St", City: "Overland Park", State: "KS", Zip: "66212")
Facility.create!(Coserial: 337, Report_Name: "Mission Chateau", Discipline: "ALF", Phone: "337-337-3337", Fax: "337-337-3377", Address1: "337 Main St", City: "Overland Park", State: "KS", Zip: "66212")
FacilityAccess.create!(User_Name: "DylanH", Coserial: 4, Access_Until: "2024-12-31")