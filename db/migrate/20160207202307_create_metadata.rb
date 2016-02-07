class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.integer :medium_id
      t.string :key
      t.string :value

      t.timestamps null: false
    end
  end
end
