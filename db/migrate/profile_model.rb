class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :display_name
      t.text :bio
      t.string :area
      t.string :genre
      t.string :website_url

      t.timestamps
    end
  end
end
