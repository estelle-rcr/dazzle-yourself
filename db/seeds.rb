# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Project.destroy_all
User.destroy_all
Package.destroy_all
Skill.destroy_all
Attendance.destroy_all

state_list = ["draft", "submitted", "paid", "published", "finished"]

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

10.times do 
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "motdepassesecurise"
    )
end

Package.create!(title: "Express : 48 heures", price_attendee: 1500, price_owner: 2000, number_of_days: 2)
Package.create!(title: "Moyen : 5 jours", price_attendee: 3000, price_owner: 4000, number_of_days: 5)
Package.create!(title: "Long : 7 jours", price_attendee: 4000, price_owner: 5300, number_of_days: 7)

10.times do 
  Project.create!(
    package: Package.all.sample,
    owner: User.all.sample,
    title: Faker::Marketing.buzzwords,
    short_description: Faker::Lorem.paragraph_by_chars(number: 140, supplemental: false),
    long_description: Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 3),
    start_date:Faker::Time.forward(days: 23, period: :morning),
    state: state_list.sample
    )
end

Skill.create!(title:"Développeur Front")
Skill.create!(title:"Développeur Back")
Skill.create!(title:"Graphiste")
Skill.create!(title:"Product Manager")
Skill.create!(title:"Business Developer")
Skill.create!(title:"Community Manager")
Skill.create!(title:"Growth Hacker")
Skill.create!(title:"SEO Specialist")
Skill.create!(title:"Communication et marketing")
Skill.create!(title:"Autre")

30.times do
    Attendance.create!(
        attendee: User.all.sample,
        project: Project.all.sample,
        price_attendee: rand(1000..5000),
        state: ["paid","pending","cancelled"].sample)
end