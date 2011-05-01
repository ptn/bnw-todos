class TodosController < ApplicationController
  def update
    #FIXME Check permissions
    @todo = Todo.find(params[:id])
    [:done, :task, :assignee_id, :due_date].each do |attr|
      unless params[:todo][attr].nil?
        @todo.send attr.to_s + "=", params[:todo][attr]
      end
    end

    respond_to do |format|
      if @todo.save
        @left_count = @todo.list.todos.left.count
        @done_count = @todo.list.todos.done.count
        @project = @todo.project
        format.js
      end
    end
  end

  def create
    @todo = Todo.new(params[:todo])
    @todo.assignee = find_or_create_participant(params[:project_id], params[:user_id]) if params[:user_id]

    respond_to do |format|
      if @todo.save
        @project = @todo.project
        @left_count = @todo.list.todos.left.count
        format.js
      else
        logger.debug "Errors: #{@todo.errors}" ##############################
      end
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    @left_count = @todo.list.todos.left.count
    @done_count = @todo.list.todos.done.count
  end


  private

  #FIXME 404/fail if either the project or user don't exist.
  def find_or_create_participant(project_id, user_id)
    participant = Participant.where(:project_id => project_id, :user_id => user_id).first
    if participant.nil?
      participant = Participant.create(:project_id => project_id, :user_id => user_id)
    end
    participant
  end
end
