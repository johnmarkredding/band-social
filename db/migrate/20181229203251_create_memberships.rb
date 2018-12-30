class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.belongs_to :member
      t.belongs_to :band
      t.timestamps
    end
  end
end
