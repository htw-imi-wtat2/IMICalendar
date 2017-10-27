# frozen_string_literal: true

# creates spaceless ids to click on categories
module CategoriesHelper
  def cat_to_id(category)
    name = case category
           when Category
             category.name
           else
             category.to_s
           end
    name.tr(' ', '-')
  end

  def categories_to_s(categories)
    categories.map(&:name).sort.join(', ')
  end

  def s_to_categories(s)
    s.split(',').map(&:strip).map do |name|
      Category.find_or_create_by(name: name)
    end
  end

  def names_to_js(names)
    names.map { |n| "\"#{n}\"" }.join(', ')
  end
end
