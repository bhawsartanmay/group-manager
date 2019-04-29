class NoticesController < ApplicationController
	before_action :authenticate_user!
	def create
		@notice = current_user.notices.create(title:params[:notice][:title],group_id:params[:group_id])
		redirect_to group_path(params[:group_id]), notice: 'Notice was successfully created.' 
	end
end
