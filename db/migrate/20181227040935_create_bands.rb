class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.string :name
      t.text :description
      t.belongs_to :manager, foreign_key: true
      t.timestamps
    end
  end
end
