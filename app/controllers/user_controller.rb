class UserController < ApplicationController
  
  def index
    list
    render :action => "list"
  end
  
  def list
    @search = ""
    @users = User.paginate :page => params[:page], :per_page => 5, :order  => order_from_params
  end

  def search_demo
    list
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => "list"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def search
    unless params[:search].blank?
      @users = User.paginate :page => params[:page],
      :per_page => 5,
      :order => order_from_params,
      :conditions => User.conditions_by_like(params[:search])
      logger.info @users.size
    else
      list
    end
    render :partial=>'search' , :layout=>false
  end
  
  def order_from_params
    if params[:form_sort] && params[:form_sort].size > 0
      params[:form_sort].downcase.split(",").map { |x| 
        x.tr(" ", "_")
      }.join(" ")
    else
      "username"
    end
  end

end
