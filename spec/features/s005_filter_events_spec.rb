require 'rails_helper'
describe 's005: as a Student, I can filter events that are relevant for me (B/M, Semester).' do
  include CategoriesHelper
  before :each do
    @e1 = create(:planning_state_1).event
    @e2 = create(:planning_state_2).event
    @e3 = create(:planning_state_3).event
    @c1 = create(:category_a)
    @c2 = create(:category_b)

    @e1.categories << @c1
    @e2.categories << @c2
    @e3.categories << @c2
  end

  it 'shows all events without selection' do
    visit events_path
    expect(page).to have_content(@e1.title)
    expect(page).to have_content(@e2.title)
    expect(page).to have_content(@e3.title)
  end

  it 'filters for category 1 - A' do
    visit events_path
    click_on cat_to_id(@c1)
    expect(page).to have_content(@e1.title)
    expect(page).not_to have_content(@e2.title)
    expect(page).not_to have_content(@e3.title)
  end

  it 'filters for category 2 - B' do
    visit events_path
    click_on cat_to_id(@c2)
    expect(page).not_to have_content(@e1.title)
    expect(page).to have_content(@e2.title)
    expect(page).to have_content(@e3.title)
  end

  it 'has a button to cancel category selection' do
    visit events_path
    click_on cat_to_id(@c2)
    click_on cat_to_id(@c1)
    click_on cat_to_id(:all)
    expect(page).to have_content(@e1.title)
    expect(page).to have_content(@e2.title)
    expect(page).to have_content(@e3.title)
  end


end
