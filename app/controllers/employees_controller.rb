class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
  
     @employees = User.search(params[:search]).order("name asc").paginate(page: params[:page], per_page: 5)
     @total = User.search(params[:search])
  end

  
end