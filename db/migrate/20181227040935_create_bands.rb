class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.belongs_to :manager
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
