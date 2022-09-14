class UsersController < ApplicationController
    before_action :set_user, except: [:index, :new, :create]
    before_action :authenticate_user!
  
    def index
      @users = User.order(:name).page params[:page]
    end
  
    
  
  #   def show
  #   end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if params[:user][:password].blank?
     
      end
      
      if @user.save(validate: false)
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
    
      @user = User.find(params[:id])
      
      skip_password
      
      if @user.update(user_params)
        redirect_to root_path
      else 
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      
  
      redirect_to root_path, status: :see_other if @user.destroy
    end
  
    private 

    def skip_password
        if params[:user][:password].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
          end
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :bio, :avatar)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  

  end
  