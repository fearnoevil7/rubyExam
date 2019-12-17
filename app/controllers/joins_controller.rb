class JoinsController < ApplicationController
    def create
        @user = User.find_by(id:session["user_id"])
        @group = Group.find_by(id: params[:groupid])
        @groups = Group.all
        if @groups.include? @group
            @join = Join.new(user: @user, group: @group)
            if @join.valid?
                unless @user.groups_joined.include? @group
                    @join.save
                    p @join
                    puts "*******joined group*******"
                    flash[:notice] = ["successfully joined organization"]
                    redirect_to "/groups/" + @group.id.to_s
                else
                    flash[:notice] = ["stop hacking"]
                    redirect_to "/groups/" + @group.id.to_s
                end
            end
        else
            flash[:notice] = ["stop hacking"]
            redirect_to "/"
        end
    end
    def destroy
        @group = Group.find_by(id:params[:groupid])
        @groups = Group.all
        if @groups.include? @group
            @join = @group.joins.find_by(user: User.find_by(id:session["user_id"]))
            if @join
                unless @user.groups_joined.include? @group
                    @join.destroy
                    puts "*******destroyed group*******"
                    redirect_to "/groups/" + @group.id.to_s
                else
                    flash[:notice] = "stop hacking"
                    redirect_to "/groups/" + @group.id.to_s
                end
            else
                redirect_to "/groups/" + @group.id.to_s
            end
        else
            flash[:notice] = ["stop hacking"]
            redirect_to "/"
        end
    end
end
