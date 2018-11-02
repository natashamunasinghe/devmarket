class ProjectsController < ApplicationController


  # Authenticate user before accessing website

  before_action :authenticate_user!, :except => [@projects, :index, :show]
  before_action :set_project, only: [:show, :status_complete]

  # Show all projects

  def index
      @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.save    

  def show
    @rating = Rating.new # for creating a new rating
    @rated = @project.rating # for showing an existing rating
    @bid = Bid.new

  end
  

  def new
    @project = Project.new
    @products = Product.all
  end
  
  def dashboard
    @open = Project.where(:status => 0)
    @in_progress = Project.where(:status => 1)
    @completed = Project.where(:status => 2)
  end

  def status_complete
    if @project.ongoing?
      @project.completed!
    end
    redirect_to project_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:product_id, :price, :title, :overview, :description, :deadline, :status)
  end
end
