class ContentsController < ApplicationController
require 'mechanize'

  def top
    @contents  = Content.all

    @manege_folders  = TManageFolder.all
    if params[:serch].blank?
      @folders  = Folder.all
    elsif
      @serch = params[:serch]
      @folders =Folder.joins(:contents).where('contents.title LIKE ?',"%#{params[:serch]}%")
    end
  end

  def topfolder

    @contents  = Content.all
    @manage_folders_id = params[:id]
    if params[:serch].blank?
      @folders  = Folder.where(manage_folders_id: params[:id])
    elsif
      @serch = params[:serch]
      @folders =Folder.joins(:contents).where(manage_folders_id: params[:id]).where('contents.title LIKE ?',"%#{params[:serch]}%")
    end
  end

  def create
    @ipt_url = params[:ipt_url]
    if @ipt_url.include?("https://")
        if @ipt_url.count('/') == 2
          @domein = @ipt_url
        elsif @ipt_url.count('/')>=3
          @domein = @ipt_url.match("(https?://[^/]+/)").to_s
        end
    elsif @ipt_url.include?("http://")
      if @ipt_url.count('/') == 2
        @domein = @ipt_url
      elsif @ipt_url.count('/')>=3
        @domein = @ipt_url.match("(http?://[^/]+/)").to_s
      end
    else
      flash[:alert] = "urlが不正です"
      redirect_to("/") and return
    end

    if @domein.empty?
      @favicon =nil
      @name =nil
    else
      @favicon = "https://www.google.com/s2/favicons?domain=" + @domein
      @title_chk = MDomeinTitle.where(domein: @domein)

      if @title_chk.count > 0
        @name = @title_chk.first.title
      else
        # マスターにない場合登録
        url = @domein
        agent = Mechanize.new
        agent.user_agent_alias = "Windows Mozilla"
        page = agent.get(url)
        @name = page.search('title')[0].inner_text
        @m_domein_title=MDomeinTitle.new(title: @name,domein: @domein)
        @m_domein_title.save

      end
    end


    if params[:ipt_folder_name]
      @folder=TManageFolder.new(user_id: @user,manage_folder_name: params[:ipt_folder_name])
      @folder.save
      @manage_folders_id = @folder.id
    elsif params[:ipt_folder_id]
      @manage_folders_id = params[:ipt_folder_id]
    end

    @origin_flag= 1
    @user = current_user.id
    @domein_chk = Folder.where('domein = ? and user_id = ?', @domein, @user)
     if @domein_chk.count > 0
       @folder_id = @domein_chk.first.id
     else
       @folder=Folder.new(user_id: @user,name: @name,
         domein: @domein,stutas_flg: @origin_flag,favicon: @favicon,manage_folders_id: @manage_folders_id)
       @folder.save
       @folder_id = @folder.id
     end

    @content=Content.new(user_id: @user,folder_id: @folder_id,
      status_flg: @origin_flag,title: params[:ipt_memo],
      url: params[:ipt_url])
    if @content.save
      flash[:notice] = "保存が完了しました"
    else
      flash[:alert] = "保存に失敗しました"
    end

    if @manage_folders_id.nil?
      redirect_to("/") and return
    else
      redirect_to("/top/#{@manage_folders_id}") and return
    end


  end

  def update
    @content =Content.find_by(id: params[:update_id])
    @content.title =params[:ipt_title]

    if @content.save
      flash[:notice] = "保存が完了しました"
    else
      flash[:alert] = "保存に失敗しました"
    end

    redirect_to("/")
  end

  def delete
    @content =Content.find_by(id: params[:delete_id])
    if @content.destroy
      flash[:notice] = "削除が完了しました"
    else
      flash[:alert] = "削除に失敗しました"
    end
    redirect_to("/")
  end

  def folderdelete
    @folders =Folder.find_by(id: params[:folder_delete_id])
    if @folders.destroy
      flash[:notice] = "削除が完了しました"
    else
      flash[:alert] = "削除に失敗しました"
    end
    redirect_to("/")
  end

  def folder_manage_create

    @folder=TManageFolder.new(user_id: @user,manage_folder_name: params[:ipt_manage_folder_name])
    if @folder.save
      flash[:notice] = "登録が完了しました"
    else
      flash[:alert] = "登録に失敗しました"
    end
    redirect_to("/")
  end

  def folder_manage_delete
    @folders =TManageFolder.find_by(id: params[:ipt_folder_name])
    if @folders.destroy
      flash[:notice] = "削除が完了しました"
    else
      flash[:alert] = "削除に失敗しました"
    end
    redirect_to("/")
  end


end
