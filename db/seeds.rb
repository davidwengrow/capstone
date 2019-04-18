# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# In the terminal
# rails g model User name:string email:string password_digest:string

# user = User.create!([{name: "David Wengrow", email: "dwengrow@email.com", password: "password"}])
user = User.create!([{name: "David Sengrow", email: "dsengrow@email.com", password: "password"}])
user = User.create!([{name: "Peter eng", email: "peng@email.com", password: "password"}])
user = User.create!([{name: "Jay engrow", email: "jengrow@email.com", password: "password"}])
# users = User.create!([{name:string, email:string, password_digest:string}])
# receipt = Receipt.create!([{business_name: "Jewel Osco", address: "2485 Howard St.", phone_number: "847-321-1234", fax: "555-555-5555", email: "jewelosco@email.com", date: "04/16/2019", subtotal: 15.90, tax: 1.43, total: 17.33, you_save: 12.00, image: "https://craftycoin.com/wp-content/uploads/2016/02/Jewel-Osco-Receipt-Chicago-1.31.16-22.58-211x450.jpg", user_id: 1}])
# receipt = Receipt.create!([{business_name: "Dressels Hardware", address: "1137 Chicago Ave.", phone_number: "708-386-6843", fax: "555-555-1234", email: "Dressels@email.com", date: "03/28/2019", subtotal: 2.49, tax: 0.25, total: 2.74, you_save: "", image: "", user_id: 1}])
# receipt = Receipt.create!([{business_name: "Jewel Osco", address: "2485 Howard St.", phone_number: "847-321-1234", fax: "555-555-5555", email: "jewelosco@email.com", date: "04/1/2019", subtotal: 15.90, tax: 1.43, total: 17.33, you_save: 12, image: "https://craftycoin.com/wp-content/uploads/2015/05/5.3.15-Jewel-Osco-10.69-Receipt.jpg", user_id: 2}])
# receipt = Receipt.create!([{business_name: "Walgreens", address: "1625 N. Sunset Blvd.", phone_number: "213-482-6298", fax: "555-555-5555", email: "jewelosco@email.com", date: "04/16/2019", subtotal: 15.90, tax: 1.43, total: 17.33, you_save: 12, image: "https://farm1.staticflickr.com/194/473677955_c4d8cd3d45_b.jpg", user_id: 3}])