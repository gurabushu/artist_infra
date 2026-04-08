class CreateCreatorSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :creator_subscriptions do |t|
      t.references :subscription_plan, null: false, foreign_key: true
      t.references :subscriber, null: false, foreign_key: { to_table: :users }
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :status
      t.date :started_on
      t.date :canceled_on

      t.timestamps
    end
  end
end