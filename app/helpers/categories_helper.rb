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
end
