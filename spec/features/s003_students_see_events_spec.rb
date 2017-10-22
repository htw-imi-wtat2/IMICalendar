require 'rails_helper'
describe 's003: students see current events on the start page' do
  before :each do
    Event.create(title: "Showtime WS 2017/18", start_date: DateTime.new(2018,2,2,10,0), end_date:DateTime.new(2018,2,2,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    Event.create(title: "Showtime SS 2018", start_date: DateTime.new(2018,7,27,10,0), end_date:DateTime.new(2018,7,27,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    Event.create(title: "Infoveranstaltung Auslandspraktikum IMI-B", start_date: DateTime.new(2018,11,8,0,0), end_date:DateTime.new(2018,11,8,0,0), description: "Informationen zum Auslandspraktikum: Anmeldung, Anerkennung, Finanzierung" )
  end

  it 'shows the events' do
    visit root_path
    expect(page).to have_content('Showtime WS 2017/18')
    expect(page).to have_content('Showtime SS 2018')
    expect(page).to have_content('Infoveranstaltung Auslandspraktikum IMI-B')
  end
end
