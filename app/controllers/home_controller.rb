class HomeController < ApplicationController
	before_action :authenticate_user!, only: [:notices]
	def notices
		if current_user.role == "admin"
			@notices = Notice.all
		else
			notice_ids = current_user.groups.map{|p| p.notices.collect(&:id)}.flatten
			@notices = Notice.where(id:notice_ids)
		end
	end
end
