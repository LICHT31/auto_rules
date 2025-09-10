class AddIndexesToAutoRules < ActiveRecord::Migration[7.0]
  def change
    unless index_exists?(:auto_rules, :project_id, name: "index_auto_rules_on_project_id")
      add_index :auto_rules, :project_id, name: "index_auto_rules_on_project_id"
    end
  end
end
