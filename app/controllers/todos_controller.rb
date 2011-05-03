class TodosController < ApplicationController
  def update
    #FIXME Check permissions
    @todo = Todo.find(params[:id])
    @todo.update_attributes params[:todo]
    @todo.assignee = if params[:user_id] && params[:user_id] != ""
                       find_or_create_participant(params[:project_id], params[:user_id])
                     else
                       nil
                     end
    if @todo.save
      @left_count = @todo.list.todos.left.count
      @done_count = @todo.list.todos.done.count
      @project = @todo.project
      @potential_assignees = User.all
      update_done_state_of_list @todo.list
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    @todo = Todo.new(params[:todo])
    @todo.assignee = find_or_create_participant(params[:project_id], params[:user_id]) if params[:user_id] != ""

    respond_to do |format|
      if @todo.save
        @project = @todo.project
        @potential_assignees = User.all
        update_done_state_of_list @todo.list, :state => false
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
    update_done_state_of_list @todo.list
    @left_count = @todo.list.todos.left.count
    @done_count = @todo.list.todos.done.count
  end


  private

  #FIXME 404/fail if either the project or user don't exist.
  def find_or_create_participant(project_id, user_id)
    participant = Participant.where(:project_id => project_id, :user_id => user_id).first
    if participant.nil?
      # You can add someone to a project simply by assigning him a todo.
      participant = Participant.create(:project_id => project_id, :user_id => user_id)
    end
    participant
  end

  # Sets the :done attr of @todo.list.
  def update_done_state_of_list(list, opts={})
    state = opts[:state] || list.todos.left.count == 0
    list.done = state
    list.save
  end
end
