class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.timestamps
      t.references :customer, index: true, foreign_key: true
      t.references :support_agent, index: true, foreign_key: true
      t.text :description
      t.string :status
      t.string :title
    end
  end
end
