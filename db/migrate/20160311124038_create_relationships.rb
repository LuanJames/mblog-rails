class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :from_id, null: false
      t.integer :to_id, null: false

      t.timestamps null: false
    end
  end
end
