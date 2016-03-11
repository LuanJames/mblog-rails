class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
