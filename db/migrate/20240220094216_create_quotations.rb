class CreateQuotations < ActiveRecord::Migration[7.1]
  def change
    create_table :quotations do |t|
      t.string :attachment
      t.date :date
      t.text :comment
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
