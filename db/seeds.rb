# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PlanningState.destroy_all
Event.destroy_all
Event.create(title: "Showtime WS 2017/18", start_date: DateTime.new(2018,2,2,10,0), end_date:DateTime.new(2018,2,2,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
Event.create(title: "Showtime SS 2018", start_date: DateTime.new(2018,7,27,10,0), end_date:DateTime.new(2018,7,27,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
Event.create(title: "Infoveranstaltung Auslandspraktikum IMI-B",  description: "Informationen zum Auslandspraktikum: Anmeldung, Anerkennung, Finanzierung" )
User.create(email: 'test@htw-berlin.de', name: 'Testuser', password: 'geheimgeheim',
            password_confirmation: 'geheimgeheim')
