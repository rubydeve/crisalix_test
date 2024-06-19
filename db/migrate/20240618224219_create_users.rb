class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :role
      t.string :address
      t.string :name
      t.boolean :certificates, default: false 
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
