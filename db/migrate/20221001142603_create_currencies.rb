class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :iso
      t.string :name
      t.decimal :rate

      t.timestamps
    end
  end
end
