class Category < ApplicationRecord
  has_and_belongs_to_many :events

  def self.categories_to_s(categories)
    categories.map(&:name).sort.join(', ')
  end

  def self.s_to_categories(s)
    s.split(',').map(&:strip).map do |name|

      # Category.where(name: name).first_or_create
      Category.find_or_create_by(name: name)
    end
  end

  def self.all_s
    Category.all.order(:name).pluck(:name).join(', ')
  end

  def self.names_alphabetically
    Category.all.order(:name).pluck(:name)
  end

end
