class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :user
      t.integer :card
      t.integer :limit
      t.integer :balance

      t.timestamps
    end
  end
end
