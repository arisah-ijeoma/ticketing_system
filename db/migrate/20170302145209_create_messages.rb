class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.timestamps
      t.references :ticket, index: true, foreign_key: true
      t.text :text
    end
  end
end
