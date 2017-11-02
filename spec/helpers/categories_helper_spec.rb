require 'rails_helper'

RSpec.describe CategoriesHelper, type: :helper do

  it 'converts a list of categories into an alphabetically sorted string' do
    categories = ['D','A','C','B'].map{ |n| Category.create(name: n) }
    expect(categories_to_s(categories)).to eq("A, B, C, D")
  end
  context 'with two existing categories h, d' do
    before :each do
      Category.create(name: 'h')
      Category.create(name: 'd')
    end
    it 'converts a string to an array of categories, creating missing ones' do
      # expect(Category.all.size).to eq 0
      expect(Category.count).to eq 2
      categories = s_to_categories('b, h, x, d')
      expect(categories[0].name).to eq 'b'
      expect(categories_to_s(categories)).to eq('b, d, h, x')
    end

    it 'converts a string to an array of categories, creating missing ones - better form' do
      expect do
        s_to_categories('b, h, x, d')
      end.to change { Category.count }.by(2)
    end
  end
  it 'converts a string to an array of categories, skipping space behind comma' do
    expect(Category.all.size).to eq 0
    Category.create(name: 'h')
    Category.create(name: 'x')
    expect(Category.count).to eq 2
    categories = s_to_categories('b, h, x, ')
    expect(categories_to_s(categories)).to eq('b, h, x')
    expect(Category.count).to eq 3
  end

end
