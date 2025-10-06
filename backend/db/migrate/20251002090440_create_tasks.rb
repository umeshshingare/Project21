class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0, null: false
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :due_date

      t.timestamps
    end

    add_index :tasks, :status
    add_index :tasks, :due_date
    add_index :tasks, :created_at
    add_index :tasks, [:project_id, :status]
    add_index :tasks, [:user_id, :status]
  end
end
