# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Project.destroy_all
Attendance.destroy_all
Tagging.destroy_all
Package.destroy_all
Skill.destroy_all

state_list = ["draft", "submitted", "paid", "published", "finished"]

Package.create!(title: "Express : 48 heures", price_attendee: 1500, price_owner: 2000, number_of_days: 2)
Package.create!(title: "Moyen : 5 jours", price_attendee: 3000, price_owner: 4000, number_of_days: 5)
Package.create!(title: "Long : 7 jours", price_attendee: 4000, price_owner: 5300, number_of_days: 7)

Project.create!(title: "Nutriti", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "Une appli qui te propose des repas pour la semaine selon tes objectifs et génère la liste des courses correspondante avec les quantités." )
Project.create!(title: "iDressing", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "C'est un dressing en ligne où les users pourront gérer, prêter et vendre leurs vêtements." )
Project.create!(title: "SocialInvesting", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "réseau social de trading où chaque utilisateur définit la composition de son portefeuille virtuel et la partage" )
Project.create!(title: "Influence", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "plateforme qui permet de mettre en relation des influenceurs (tous types, YouTube, Instagram...), et des freelances. " )
Project.create!(title: "VoisinAct", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "plateforme de crowdfunding pour faire naître des initiatives citoyennes à l'échelle d'une ville, d'un arrondissement ou d'un quartier. " )
Project.create!(title: "Calypso", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "Application de gestion qui facilite le fonctionnement des centres de plongée et les aide dans leurs activités quotidiennes." )
Project.create!(title: "Easy Escalade", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "C'est un site comparateur de salles d'escalade " )
Project.create!(title: "Boostme", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "BoostMe est notre plateforme de eloboost pour le jeu League of Legends. ")
Project.create!(title: "Reliev", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "plateforme de mise en relation entre entreprises et professionnels du massage." )
Project.create!(title: "Peerclub.io", owner: User.find(11), start_date: (Time.now + 259200), package: Package.all.sample, short_description: "Suis le rythme, travaille en communauté physique ou à distance et organise ta réussite avec PeerClub" )

Skill.create!(title:"Développeur Front")
Skill.create!(title:"Développeur Back")
Skill.create!(title:"Graphiste")
Skill.create!(title:"Product Manager")
Skill.create!(title:"Ventes")
Skill.create!(title:"Social Media Manager")
Skill.create!(title:"Growth Hacker")
Skill.create!(title:"SEO Specialist")
Skill.create!(title:"Marketing")
Skill.create!(title:"Communication")
Skill.create!(title:"Customer Success")
Skill.create!(title:"Operations")
Skill.create!(title:"Data scientist")

30.times do
    Attendance.create!(
        attendee: User.all.sample,
        project: Project.all.sample,
        price_attendee: rand(1000..5000),
        state: ["paid","pending","cancelled"].sample)
end

30.times do 
  Tagging.create!(
    tag: Tag.all.sample,
    project: Project.all.sample)
end