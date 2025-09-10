module AutoRules
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        has_many :auto_rules, dependent: :destroy
      end
    end
  end
end
