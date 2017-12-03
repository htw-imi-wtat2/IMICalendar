# frozen_string_literal: true

# Controller for Categories
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]
  before_action :set_categories, only: %i[index combine]
  def index; end

  def show; end

  def combine
    action = params['commit']
    ids = params['category_ids'].map(&:to_i)
    categories = ids.map { |i| Category.find(i) }

    if action == 'Combine'
      main = Category.combine(categories)
      message = "#{ids.count} Categories were combined to #{main.name}"
    end

    if action == 'Delete'
      categories.map(&:destroy)
      message = "#{ids.count} Categories were deleted."
    end

    redirect_to categories_url,
                notice: message
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html do
        redirect_to categories_url,
                    notice: 'Category was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  #  def category_params
  #    params.require(:planning_state).permit(:name)
  #  end
end
