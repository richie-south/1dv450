# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

app1 = Applikation.create(:app_name => "super appen", :appkey => "supernyckelen")
app2 = Applikation.create(:app_name => "bajs appen", :appkey => "bajsnyckelen")
app3 = Applikation.create(:app_name => "killa appen", :appkey => "killanyckelen")

cre1 = Creator.create(:name => "rick", :password => "1234567")
cre2 = Creator.create(:name => "king", :password => "1234567")
cre3 = Creator.create(:name => "pro", :password => "1234567")

tot1 = Toilet.create(:name => "slotts toan!", :description => "en av alla fina toaletter på slottet", creator_id: cre1.id)

tag1 = Tag.create(name: "slottet")
tag2 = Tag.create(name: "premium")

tot1.tags << tag1
tot1.tags << tag2

Position.create(address: "Kolonigatan 10, 392 36 Kalmar", toilet_id: tot1.id)

tot2 = Toilet.create(:name => "hampus toa", :description => "den ända toan hos hampus", creator_id: cre1.id)
Position.create(address: "Stagneliusgatan 1B, 392 34 Kalmar", toilet_id: tot2.id)


tot3 = Toilet.create(:name => "kalmar nyckel", :description => "meskalin delen", creator_id: cre1.id)
tag3 = Tag.create(name: "lukar illa")
tag4 = Tag.create(name: "media")
tot3.tags << tag3
tot3.tags << tag4
Position.create(address: "Gröndalsvägen 19B, 392 36 Kalmar", toilet_id: tot3.id)


tot4 = Toilet.create(:name => "kalmar slottshotell", :description => "mycket fin toa!", creator_id: cre1.id)
tag5 = Tag.create(name: "hotell")
tot3.tags << tag1
tot3.tags << tag5
Position.create(address: "Slottsvägen 7, 392 33 Kalmar", toilet_id: tot4.id)



usr1 = User.create(:user_name => "kalle", :password => "1234567")
usr2 = User.create(:user_name => "hampa", :password => "qwerty")

adminusr = User.create(:user_name => "admin", :password => "password", :isAdmin => true)

usr1.applikations << app1
usr2.applikations << app2
usr2.applikations << app3
