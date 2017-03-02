class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.timestamps
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.string :status
      t.string :title
    end
  end
end
