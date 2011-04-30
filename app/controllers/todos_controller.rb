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
end
