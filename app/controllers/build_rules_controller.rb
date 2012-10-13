class BuildRulesController < ApplicationController

  def new
    @build_rule = new_build_rule
    @build_rule.build_configuration = @native_target.default_build_configuration if @native_target
  end

  def create
    @build_rule = new_build_rule
    @build_rule.attributes = params[:build_rule]
    @build_rule.native_target ||= @build_rule.build_configuration.native_target
    if @build_rule.save
      redirect_to :xcode_projects
    else
      render :new
    end
  end

  def edit
    @build_rule = native_target.build_rules.find params[:id]
  end

  def update
    @build_rule = native_target.build_rules.find params[:id]
    if @build_rule.update_attributes params[:build_rule]
      redirect_to :xcode_projects
    else
      render :new
    end
  end

  def destroy
    build_rule = native_target.build_rules.find params[:id]
    build_rule.destroy
    redirect_to :xcode_projects
  end

private

  def native_target
    @native_target ||= NativeTarget.find params[:native_target_id]
  end

  def new_build_rule
    params[:native_target_id] && native_target.build_rules.new || BuildRule.new
  end

end
