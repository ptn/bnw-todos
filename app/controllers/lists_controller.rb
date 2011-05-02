class ListsController < ApplicationController
  def create
    @list = List.new(params[:list])
    #FIXME Check if the project exists
    @list.project_id = params[:project_id]
    respond_to do |format|
      if @list.save
        @project = @list.project
        @todo = Todo.new
        @potential_assignees = User.all
        format.js
      else
        logger.debug "Errors: #{@list.errors}" ##############################
      end
    end
  end
end
