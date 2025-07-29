class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :message
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :notification_type

      t.timestamps
    end
  end
end
