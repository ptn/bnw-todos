class ListsController < ApplicationController
  def show
    @list = List.find(params[:id])
    #FIXME Check if the project exists
    @project = Project.find(params[:project_id])
    @todo = Todo.new
    @potential_assignees = User.all
    @showing_list = true
  end

  def create
    @list = List.new(params[:list])
    #FIXME Check if the project exists
    @list.project_id = params[:project_id]
    respond_to do |format|
      if @list.save
        @project = @list.project
        @todo = Todo.new
        @potential_assignees = User.all
        @is_new_list = true
        format.js
      else
        logger.debug "Errors: #{@list.errors}" ##############################
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    respond_to do |format|
      format.html { redirect_to(@list.project) }
    end
  end
end
