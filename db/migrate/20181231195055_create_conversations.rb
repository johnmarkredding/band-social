class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.belongs_to :sender
      t.belongs_to :receiver
      t.timestamps
    end
  end
end
