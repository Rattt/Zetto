class CreateZettoSessions < ActiveRecord::Migration
  def change
    create_table :zetto_sessions do |t|
      t.integer  :user_id,    null: false, unique: true
      t.string   :session_id, limit: 9,  null: false, unique: true
      t.string   :algorithm,  limit: 50, null: false

      t.timestamps null: false
    end
  end
end
