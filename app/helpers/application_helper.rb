module ApplicationHelper

  def managefolder
    @manege_folders  = TManageFolder.all
  end
end
