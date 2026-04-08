class CreateContracts < ActiveRecord::Migration[8.1]
  def change
    create_table :contracts do |t|
      t.references :project, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :artist, null: false, foreign_key: { to_table: :users }
      t.integer :contract_type
      t.integer :status
      t.integer :agreed_amount
      t.date :started_on
      t.date :ended_on
      t.string :renewal_cycle

      t.timestamps
    end
  end
end