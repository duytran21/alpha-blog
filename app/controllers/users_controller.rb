class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    #debugger
    @user = User.new(user_params)

    #respond_to do |format|
      if @user.save
      #  format.html { redirect_to @user, notice: 'User was successfully created.' }
      #  format.json { render :show, status: :created, location: @user }
        session[:user_id] = @user.id
        flash[:success] = "Welcome #{@user.username} to the Alpha Blog."
        redirect_to user_path(@user)
      else
      #  format.html { render :new }
      #  format.json { render json: @user.errors, status: :unprocessable_entity }
        render "new"
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    #debugger
    #respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { render :show, status: :ok, location: @user }
        flash[:success] = "Your account was updated successfully"
        redirect_to user_path(@user)
      else
        #format.html { render :edit }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
        render "edit"
      end
    #end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:success] = "User and all articles created by user have been deleted"
    redirect_to users_path
    #respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user and !current_user.try(:admin?)
        flash[:danger] = "You can only edit your own account!"
        redirect_to root_path
      end
    end

    def require_admin
      if logged_in? and !current_user.try(:admin?)
        flash[:danger] = "Only admin can do this action!"
        redirect_to root_path
      end
    end
end
