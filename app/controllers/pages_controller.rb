class PagesController < ApplicationController
  def dev
  end

  def overview
    @workflows = Workflow.where(active: true).order(title: :asc)
    @media = Medium.all.order(id: :desc)

    @workflows.each do |workflow|
      instance_variable_set("@workflows_count_#{workflow.id}", Medium.where(workflow_id: workflow.id).where.not(state: "copied_to_out_directory").where.not(state: "ready_for_purge").count)
    end
  end
end
