# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
for i in 1..24
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: "#{first_name} #{last_name}", separators: '+', domain: 'example')
  user = User.find_or_initialize_by(first_name: first_name, last_name: last_name, email: email)
  user.city = Faker::Address.city
  user.street_address = Faker::Address.street_address
  user.postal_code = Faker::Address.postcode
  user.province = Faker::Address.state
  user.country = Faker::Address.country
  if user.save
    puts "User (#{user.id}) #{first_name} #{last_name} saved"
    for ii in 1..24
      micropost = Micropost.new
      micropost.user = user
      micropost.message = Faker::Books::Lovecraft.paragraph
      if micropost.save
        puts "Micropost (#{micropost.id}) has been saved!"
      else
        raise "MICROPOST HAS ERRORS #{micropost.errors.full_messages}"
      end
    end
  else
    raise "USER HAS ERRORS: #{user.errors.full_messages}"
  end
end