class CreateChatTable < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :recipient, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
