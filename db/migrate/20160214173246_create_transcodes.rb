class CreateTranscodes < ActiveRecord::Migration
  def change
    create_table :transcodes do |t|
      t.string :title
      t.string :general_option
      t.string :infile_option
      t.string :outfile_option
      t.string :extention

      t.timestamps null: false
    end
  end
end
