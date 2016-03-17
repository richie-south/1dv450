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

usr1 = User.create(:user_name => "kalle", :password => "1234567")
usr2 = User.create(:user_name => "hampa", :password => "qwerty")

adminusr = User.create(:user_name => "admin", :password => "password", :isAdmin => true)

usr1.applikations << app1
usr2.applikations << app2
usr2.applikations << app3
