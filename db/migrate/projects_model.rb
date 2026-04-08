class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :project_type
      t.integer :recruitment_type
      t.integer :status
      t.integer :budget_min
      t.integer :budget_max

      t.timestamps
    end
  end
end
