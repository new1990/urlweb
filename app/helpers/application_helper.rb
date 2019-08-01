module ApplicationHelper

  def managefolder
    @manege_folders  = TManageFolder.where(user_id: current_user.id)
  end
end
