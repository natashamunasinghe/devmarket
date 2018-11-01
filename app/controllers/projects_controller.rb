class ProjectsController < ApplicationController
  before_action :authenticate_user!
  def index
      @projects = Project.all
    
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.save

    
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

  def show
    @project = Project.find(params[:id])
  end

  private
  def project_params
    params.require(:project).permit(:product_id, :price, :title, :overview, :description, :deadline, :status)
  end


end
