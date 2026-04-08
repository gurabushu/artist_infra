class CreateWorks < ActiveRecord::Migration[8.1]
  def change
    create_table :works do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :work_type
      t.string :external_url
      t.boolean :published

      t.timestamps
    end
  end
end
