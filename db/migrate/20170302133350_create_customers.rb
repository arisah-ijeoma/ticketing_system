class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.timestamps
      t.string     :email
      t.string     :first_name
      t.string     :last_name
      t.string     :password_digest
      t.string     :token
    end
    add_index :customers, :token, unique: true
  end
end
