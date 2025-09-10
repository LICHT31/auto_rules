class CreateAutoRules < ActiveRecord::Migration[7.0]
  def change
    create_table :auto_rules do |t|
      t.integer :project_id, null: false
      t.integer :custom_field_id, null: false
      t.string  :custom_field_value, null: false
      t.integer :assignee_id
      t.string  :watcher_ids # comma-separated IDs for now
      t.timestamps
    end

    add_index :auto_rules, :project_id
    add_foreign_key :auto_rules, :projects, column: :project_id
  end
end
