class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string     :email
      t.string     :first_name
      t.string     :last_name
      t.string     :type
      t.boolean    :admin, default: false, null: false
      t.string     :password_digest
      t.string     :token
    end
    add_index :users, :token, unique: true
  end
end
