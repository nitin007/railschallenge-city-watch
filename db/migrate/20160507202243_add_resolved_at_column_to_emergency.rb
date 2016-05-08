class AddResolvedAtColumnToEmergency < ActiveRecord::Migration
  def change
    add_column :emergencies, :resolved_at, :datetime
  end
end
