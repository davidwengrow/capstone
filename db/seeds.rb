# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# In the terminal
# rails g model User name:string email:string password_digest:string

user = User.create!([{name: "David Wengrow", email: "dwengrow@email.com", password_digest: "password"}])
# users = User.create!([{name:string, email:string, password_digest:string}])
receipts = Receipt.create!([{business_name: "Jewel Osco", address: "2485 Howard St.", phone_number: "847-321-1234", fax: "555-555-5555", email: "jewelosco@email.com", date: "04/16/2019", subtotal: 15.90, tax: 1.43, total: 17.33, you_save: "$12.00", image: "https://craftycoin.com/wp-content/uploads/2016/02/Jewel-Osco-Receipt-Chicago-1.31.16-22.58-211x450.jpg"}])