class GroupsController < ApplicationController
  def index
    @user = User.find_by(id:session["user_id"])
    @groups = Group.all
  end

  def show
    @group = Group.find_by(id: params[:groupid])
    @groups = Group.all
    if @groups.include? @group
      @user = User.find_by(id: session["user_id"])
      @users_joined = @group.users_joined
    else
      flash[:notice] = ["stop hacking"]
      redirect_to "/"
    end
  end

  def create
    @user = User.find_by(id:session["user_id"])
    @group = Group.new(group_params)
    if @group.valid?
      puts "*******group*******"
      p @group
      @group.save
      @join = Join.new(user:@user, group:@group)
      if @join.valid?
        @join.save
        flash[:notice] = ["Group created"]
        redirect_to "/groups"
      else
        puts "*******group creator failed to join"
        redirect_to "/groups"
      end
    else
      flash[:notice] = @group.errors.full_messages
      redirect_to "/groups"
    end
  end

  def destroy
    @user = User.find_by(id: session["user_id"])
    @group = Group.find_by(id:params[:groupid])
    @groups = Group.all
    if @groups.include? @group
      if @group.user.id == @user.id
        @group.destroy
        flash[:notice] = ["group destroyed"]
        redirect_to "/groups"
      else
        flash[:notice] = ["unable to delete group"]
      end
    else
      flash[:notice] = ["stop hacking"]
      redirect_to "/"
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :description).merge(user: User.find_by(id:session["user_id"]))
  end
end
