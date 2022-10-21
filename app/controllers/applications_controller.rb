class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # require "pry"; binding.pry

    if params[:name].present?
      @pets = Pet.search(params[:name])
    else
      @pets = []
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)
    #  binding.pry
    if application.incomplete_form? == true
      redirect_to "/applications/new"
      flash[:error] = "Content missing #{application.list_incomplete_fields}"
    else
      redirect_to "/applications/#{application.id}"
    end
  end



private
  def application_params
    params
      .permit(:name, :street_address, :city, :state, :zipcode, :description)
      .with_defaults(status: "In Progress")
  end
end
