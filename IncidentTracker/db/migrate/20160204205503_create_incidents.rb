class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.text :description
      t.string :location
      t.integer :status
      t.integer :severity
      t.date :date
      t.time :time
      t.text :comments

      t.timestamps null: false
    end
  end
end
