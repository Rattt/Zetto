class AlterColumnSessionsAlgorithm < ActiveRecord::Migration
  def change
    remove_column :zetto_sessions, :algorithm
    add_column :zetto_sessions, :algorithm,  :integer, :default => 0
  end
end
