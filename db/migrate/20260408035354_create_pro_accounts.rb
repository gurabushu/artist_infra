class CreateProAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :pro_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.datetime :approved_at
      t.text :reason

      t.timestamps
    end
  end
end
