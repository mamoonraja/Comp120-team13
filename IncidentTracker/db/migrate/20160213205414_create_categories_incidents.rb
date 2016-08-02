class CreateCategoriesIncidents < ActiveRecord::Migration
  def change
    create_table :categories_incidents do |t|
      t.integer :category_id
      t.integer :incident_id
    end
  end
end
