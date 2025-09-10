class AutoRulesController < ApplicationController
  before_action :find_project, :authorize, except: [:custom_field_values]
  before_action :authorize, only: [:index, :create, :destroy]
  skip_before_action :find_project, only: [:custom_field_values]

  def index
    @rules = @project.auto_rules
    @rule  = AutoRule.new
    @assignable_principals = @project.principals.sort_by(&:name)
  end

  def create
    @rule = @project.auto_rules.build(rule_params)
    if @rule.save
      flash[:notice] = "Rule created successfully"
    else
      flash[:error] = "Failed to create rule"
    end
    redirect_to project_auto_rules_path(@project)
  end

  def destroy
    @rule = @project.auto_rules.find(params[:id])
    @rule.destroy
    flash[:notice] = "Rule deleted"
    redirect_to project_auto_rules_path(@project)
  end

  def custom_field_values
    cf = CustomField.find(params[:id])

    if cf.field_format == 'enumeration'
      render json: cf.enumerations.map(&:name)
    elsif cf.field_format == 'list'
      render json: cf.possible_values
    elsif cf.field_format == 'bool'
      render json: [true, false]
    else
      render json: []
    end
  rescue ActiveRecord::RecordNotFound
    render json: []
  end

  private

  def rule_params
    params.require(:auto_rule).permit(:custom_field_id, :custom_field_value, :assignee_id, watcher_ids_array: [])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
