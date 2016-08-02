class AddMediaToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :media, :string
  end
end
