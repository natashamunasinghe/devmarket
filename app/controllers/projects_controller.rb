class ProjectsController < ApplicationController
  # before_action :authenticate_user!

  def index
  end

  def create
    @amount = 1000

    # creates new customer, but our app creates one on User Registeration instead
    # customer = Stripe::Customer.create(
    #   :email => params[:stripeEmail],
    #   :source => params[:stripeToken],
    # )

    # sent customer_id to Stripe to get stripeToken
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    customer.source = params[:stripeToken]
    customer.save

    # charges stripeToken
    charge = Stripe::Charge.create(
      :customer => current_user.customer_id,
      :amount => @amount,
      :description => "Rails Stripe customer",
      :currency => "aud",
    )

    redirect_to "/"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to '/'

    @projects = Project.new(project_params)
    @projects.save

    # redirect_to @projects
  end

  def new
    @projects = Project.new
    @user = current_user
  end

end
