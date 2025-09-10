require File.expand_path('../lib/auto_rules/hooks', __FILE__)
require File.expand_path('../lib/auto_rules/project_patch', __FILE__)

Redmine::Plugin.register :auto_rules do
  name 'Auto Rules Plugin'
  author 'Kyle Estrada'
  description 'The Auto Rules Plugin for Redmine automates issue management, allowing project administrators to set custom rules that assign issues to users and add watchers based on a specific custom field.'
  version '0.0.1'
  url 'https://github.com/LICHT31/auto_rules'
  author_url 'https://github.com/LICHT31'

  project_module :auto_rules do
    permission :manage_auto_rules,
               { auto_rules: [:index, :new, :create, :edit, :update, :destroy, :custom_field_values] },
               require: :member
  end

  menu :project_menu,
       :auto_rules,
       { controller: 'auto_rules', action: 'index' },
       caption: 'Auto Rules',
       after: :settings,
       param: :project_id
end

# Force the patch immediately (instead of waiting for to_prepare)
unless Project.included_modules.include?(::AutoRules::ProjectPatch)
  Project.include ::AutoRules::ProjectPatch
end
