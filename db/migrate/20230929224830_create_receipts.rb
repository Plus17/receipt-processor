class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts, id: :uuid do |t|
      t.integer :points
      t.jsonb :data

      t.timestamps
    end
  end
end
