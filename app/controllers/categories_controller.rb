# frozen_string_literal: true

# Controller for Categories
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :destroy]
  def index
    @categories = Category.all
  end

  def show; end

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

#  def category_params
#    params.require(:planning_state).permit(:name)
#  end
end
