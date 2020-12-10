# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(
  username: 'professorX',
  password: 'password',
  email: 'sir_pat_stew@example.com'
)
user2 = User.create!(
  username: 'bakula_to_the_future',
  password: 'password',
  email: 'scott_bakula@example.com'
)
user3 = User.create!(
  username: 'finding_nimoy',
  password: 'password',
  email: 'leo_nimoy@example.com'
)
user4 = User.create!(
  username: 'wild_captain_bill',
  password: 'password',
  email: 'wshatner@example.com'
)
user1.friends << user2
user1.friends << user3
user1.friends << user4

star_trek = Movie.create!(
  title: "Star Trek II: The Wrath of Khan",
  api_id: 154,
  duration_of_movie: 113
)

trek_party = star_trek.viewings.create!(
  duration_of_party: star_trek.duration_of_movie,
  start_time: DateTime.now
)

trek_party.guests.create!(user_id: user1.id, hosting: true)
trek_party.guests.create!(user_id: user2.id, hosting: false)
trek_party.guests.create!(user_id: user3.id, hosting: false)
trek_party.guests.create!(user_id: user4.id, hosting: false)
