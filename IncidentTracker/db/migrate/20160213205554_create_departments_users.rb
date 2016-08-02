class CreateDepartmentsUsers < ActiveRecord::Migration
  def change
    create_table :departments_users do |t|
      t.integer :department_id
      t.integer :user_id
    end
  end
end
