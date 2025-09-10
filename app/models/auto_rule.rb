class AutoRule < ActiveRecord::Base
  belongs_to :project
  belongs_to :custom_field
  belongs_to :assignee, class_name: 'Principal', optional: true

  def watchers
    Principal.where(id: watcher_ids.to_s.split(',').map(&:to_i))
  end

  def watcher_ids_array
    watcher_ids.to_s.split(',').map(&:to_i)
  end

  def watcher_ids_array=(ids)
    self.watcher_ids = ids.reject(&:blank?).join(',')
  end
end
