class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :state
      t.integer :workflow_id

      t.timestamps null: false
    end
  end
end
