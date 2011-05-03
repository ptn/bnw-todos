class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = current_user.projects
    @overdue = current_user.todos.overdue
    @due_today = current_user.todos.due_today
    @count_map, @state_map = build_maps

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @todo = Todo.new
    @list = List.new
    @potential_assignees = User.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        @is_new_project = true
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end


  private

  def build_maps
    # Maps how many todos assigned, overdue and due today the user has in every
    # project.
    count_map = {}
    # Stores if a project has todos overdue and due today.
    state_map = {}
    @projects.each do |p|
      counts = {}
      participant = Participant.where(:user_id => current_user.id, :project_id => p.id).first
      counts[:assigned] = participant.todos.count
      counts[:overdue] = participant.todos.overdue.count
      counts[:due_today] = participant.todos.due_today.count
      count_map[p.id] = counts
      states = {}
      states[:overdue] = p.todos.overdue.count > 0
      states[:due_today] = p.todos.due_today.count > 0
      state_map[p.id] = states
    end

    [count_map, state_map]
  end
end
