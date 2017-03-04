class CreateSupportAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :support_agents do |t|
      t.timestamps
      t.string     :email
      t.string     :first_name
      t.string     :last_name
      t.boolean    :admin, default: false, null: false
      t.string     :password_digest
      t.string     :token
    end
    add_index :support_agents, :token, unique: true
  end
end
