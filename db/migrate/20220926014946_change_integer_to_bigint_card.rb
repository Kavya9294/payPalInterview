class ChangeIntegerToBigintCard < ActiveRecord::Migration[7.0]
  def change
    change_column :banks, :card, :bigint
  end
end
