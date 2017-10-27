require 'rails_helper'

RSpec.describe CategoriesHelper, type: :helper do
  it 'converts a list of categories into an alphabetically sorted string' do
    categories = ['D','A','C','B'].map{|n| Category.create(name: n)}
    expect(categories_to_s(categories)).to eq("A, B, C, D")
  end
  it 'converts a string to an array of categories, creating missing ones' do
    expect(Category.all.size).to eq 0
    Category.create(name: 'h')
    Category.create(name: 'd')
    expect(Category.count).to eq 2
    categories = s_to_categories('b, h, x, d')
    expect(Category.count).to eq 4
    expect(categories[0].name).to eq 'b'
    expect(categories_to_s(categories)).to eq('b, d, h, x')
  end

end
