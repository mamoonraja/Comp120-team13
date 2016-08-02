class AddReferencesToIncidents < ActiveRecord::Migration
  def change
    add_reference :incidents, :user, index: true, foreign_key: true
  end
end
