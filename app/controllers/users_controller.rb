class UsersController < ApplicationController
  # ログイン操作制限
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # 他ユーザーの操作制限
  before_action :correct_user, only: [:edit, :update]
  # 他のユーザーの
  before_action :admin_user,     only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new→'/signup'
  def new
    @user = User.new
  end

  # GET /users/1/edit edit_users_path(user)
  def edit  # ログインユーザーのみ操作可能
    # @user = User.find(params[:id]) => before_actionに移行
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    # respond_to do |format|
      if @user.save
        log_in(@user) # 新規登録したら、そのままログインするように設定
        flash[:success] = "登録が完了しました！"
        redirect_to @user
      else
        render 'users/new'
      end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update  #ログインユーザーのみ操作可能
    # @user = User.find(params[:id]) => before_actionに移行
    if @user.update_attributes(user_params)
      flash.now[:success] = "変更が完了しました"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  # DELETE /users/1 => delete users_path(@user)
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを消去しました"
    redirect_to users_url
  end

  private

    # Strong Parameters
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user # before_action用 ユーザーがログインができていない場合、ログインのURLをリダイレクトする
      unless logged_in?
        store_location # URLの記憶
        flash[:danger] = "先にログインしてください"
        redirect_to login_url
      end
    end

    def correct_user # before_action用 他のユーザーがログインして場合、
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
