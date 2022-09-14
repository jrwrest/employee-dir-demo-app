class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = User.order(:name).page params[:page]
  end



end
