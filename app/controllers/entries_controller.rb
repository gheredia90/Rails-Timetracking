class EntriesController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @entries = @project.entries
  end

  def new
  	@project = Project.find(params[:project_id])
  	@entry = @project.entries.new
  end

  def create
  	@project = Project.find(params[:project_id])
  	@entry = @project.entries.new entry_params
  	if @entry.save
  		flash[:notice] = "Entry successfully created"
  		redirect_to action: 'index', controller: 'entries', 
  		project_id: @project.id
  	else
  		render 'new'
  	end		
  end

  def edit
  	@project = Project.find(params[:project_id])
  	@entry = @project.entries.find(params[:id])
  end
  
  def update
  	@project = Project.find(params[:project_id])
  	@entry = @project.entries.find(params[:project_id])
  	if @entry.update_attributes(entry_params)
  		flash[:notice] = "Entry successfully updated"
  		redirect_to project_entries_path(@project)
  	else
  		@errors = @entry.errors.full_messages
  		render 'edit'
  	end	
  end	


  def destroy
    @project = Project.find(params[:project_id])
    @entry = @project.entries.find(params[:id])
    @entry.destroy
    
    redirect_to project_entries_path(@project)
  end

  private
  def entry_params
  	params.require(:entry).permit(:hours, :minutes, :date)
  end	
end
