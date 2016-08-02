class CreateCategoriesDepartments < ActiveRecord::Migration
  def change
    create_table :categories_departments do |t|
      t.integer :category_id
      t.integer :department_id
    end
  end
end
