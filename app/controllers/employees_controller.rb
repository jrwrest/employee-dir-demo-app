class EmployeesController < ApplicationController
  before_action :set_employee, except: [:index, :new, :create]
  before_action :authenticate_user!

  def index
  

     @employees = User.search(params[:search]).order("name asc").paginate(page: params[:page], per_page: 5)

  end

  

#   def show
#   end

#   def new
#     @employee = Employee.new
#   end

#   def create
#     @employee = Employee.new(employee_params)
#     if @employee.save
#       redirect_to root_path
#     else
#       render :new, status: :unprocessable_entity
#     end
#   end

  def edit
  end

  def update
  
    @employee = User.find(params[:id])
    
     if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  
    
    if @employee.update(employee_params)
      redirect_to root_path
    else 
      render :edit, status: :unprocessable_entity
    end
  end

#   def destroy
#     @employee.destroy

#     redirect_to root_path, status: :see_other
#   end

  private 

  def employee_params
    params.require(:user).permit(:name, :email, :bio, :avatar)
  end

  def set_employee
    @employee = User.find(params[:id])
  end

  def set_user
    @user = User.find
  end
end
