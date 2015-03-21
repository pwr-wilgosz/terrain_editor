class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :organization

      t.timestamps null: false
    end
  end
end
