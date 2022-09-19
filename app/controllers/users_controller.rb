class UsersController < ApplicationController
    before_action :set_user, except: [:index, :new, :create]
    before_action :authenticate_user!
    before_action :admin_user, except: [:show]
 
    
  
    def show
      @employee = User.find(params[:id])
    end
  
    def new

      
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
     
    
      @user.skip_password_validation = true if current_user.admin?
      if @user.save
        respond_to do |format|
           format.html { redirect_to root_path, notice: "Saved..."} 
        end
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    
    end
  
    def update
      
      @user = User.find(params[:id])
      
      
      @user.skip_password_validation = true if current_user.admin?
      
      if @user.update(user_params)
        
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Updated..."} 
       end
      else 
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      admin_user
      if @user.destroy
        respond_to do |format|
           format.html { redirect_to root_path, notice: "User Deleted..."} 
        end
      else
        render :new, status: :unprocessable_entity
      end
    end


  
    private 

 
  
    def user_params
      params.require(:user).permit(:name, :email, :bio, :avatar, :admin)
    end
  
    def set_user
      @user = User.find(params[:id])
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
  

  end
  