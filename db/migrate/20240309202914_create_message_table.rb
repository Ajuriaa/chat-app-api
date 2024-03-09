class CreateMessageTable < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true, null: false
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.text :content
      t.timestamps
    end
  end
end
