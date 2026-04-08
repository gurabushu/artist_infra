class CreateSubscriptionPlans < ActiveRecord::Migration[8.1]
  def change
    create_table :subscription_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :price
      t.string :cycle
      t.text :delivery_detail
      t.boolean :active

      t.timestamps
    end
  end
end
