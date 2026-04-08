class CreateBillingSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :billing_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :plan_name
      t.integer :status
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.string :payment_provider
      t.string :external_subscription_id

      t.timestamps
    end
  end
end
