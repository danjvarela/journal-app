# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
["user1@example", "user2@example"].each { |email| User.create email: email, password: "password" }

["General", "Studies", "Work Stuff", "Important"].each do |category_name|
  category = User.first.categories.create name: category_name
  3.times { |n| category.tasks.create name: "Task #{n + 1}", description: "Task #{n + 1} description", deadline: Time.zone.now + [45.minutes, 1.days, 4.days].sample }
end
