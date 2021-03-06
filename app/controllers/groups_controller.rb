class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy,:join_group]
  before_action :authenticate_user!
  # GET /groups
  # GET /groups.json
  def index
      @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @notice = @group.notices.new
    @notices = @group.notices
  end

  # GET /groups/new
  def new
    @group = current_user.groups.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    if current_user.role == "admin"
      @group = Group.new(group_params)

      respond_to do |format|
        if @group.save
          format.html { redirect_to @group, notice: 'Group was successfully created.' }
          format.json { render :show, status: :created, location: @group }
        else
          format.html { render :new }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    if current_user.role =="admin"
      respond_to do |format|
        if @group.update(group_params)
          format.html { redirect_to @group, notice: 'Group was successfully updated.' }
          format.json { render :show, status: :ok, location: @group }
        else
          format.html { render :edit }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    if current_user.role == "admin"
      @group.destroy
      respond_to do |format|
        format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
        format.json { head :no_content }
      end
    end  
  end

  def join_group
    @group.user_groups.create(user_id:current_user.id)
    redirect_to groups_path, notice: 'You Have successfully joined the group!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :code)
    end
end
