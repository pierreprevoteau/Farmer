class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :title
      t.string :kind
      t.boolean :active
      t.string :in_folder
      t.string :out_folder
      t.integer :transcode_id

      t.timestamps null: false
    end
  end
end
