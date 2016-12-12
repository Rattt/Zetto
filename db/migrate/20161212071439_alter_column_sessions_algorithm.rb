class AlterColumnSessionsAlgorithm < ActiveRecord::Migration
  def change
    change_column :zetto_sessions, :algorithm,  :integer, :default => 0
  end
end
