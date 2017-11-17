# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create(email: 'test@htw-berlin.de', last_name: 'Testuser', password: 'geheimgeheim',
            password_confirmation: 'geheimgeheim')


PlanningState.destroy_all
Event.destroy_all
st17 = Event.create(title: 'Showtime WS 2017/18', start_date: DateTime.new(2018,2,2,10,0), end_date:DateTime.new(2018,2,2,17,0), location: 'H001', description: 'Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters' )
st18 = Event.create(title: 'Showtime SS 2018', start_date: DateTime.new(2018,7,27,10,0), end_date:DateTime.new(2018,7,27,17,0), location: 'H001', description: 'Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters' )
info = Event.create(title: 'Infoveranstaltung Auslandspraktikum IMI-B',  description: 'Informationen zum Auslandspraktikum: Anmeldung, Anerkennung, Finanzierung' )

Category.destroy_all

t1 = Category.create(name: 'IMI-B')
t2 = Category.create(name: 'IMI-M')
t3 = Category.create(name: 'Praktikum')
t4 = Category.create(name: '2. Semester')

st17.categories = [t1,t2]
st18.categories = [t1,t2]
info.categories = [t4,t3]
