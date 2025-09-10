module AutoRules
  class Hooks < Redmine::Hook::Listener
    # Change the hook from "after" to "before"
    def controller_issues_new_before_save(context = {})
      issue = context[:issue]
      project = issue.project

      rules = project.auto_rules.where(custom_field_id: issue.custom_field_values.map(&:custom_field_id))
      rules.each do |rule|
        cf_value = issue.custom_field_values.find { |v| v.custom_field_id == rule.custom_field_id }

        # The comparison logic is fine.
        if cf_value && cf_value.value.to_s.strip.casecmp(rule.custom_field_value.strip) == 0
          # Apply rules
          issue.assigned_to = rule.assignee if rule.assignee.present?
          rule.watchers.each { |w| issue.add_watcher(w) }
          
          # Remove the issue.save call as the main transaction will handle it.
        end
      end
    end
  end
end