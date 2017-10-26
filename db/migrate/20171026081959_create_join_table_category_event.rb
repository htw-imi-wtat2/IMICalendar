class CreateJoinTableCategoryEvent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :events  do |t|
    end
  end
end
