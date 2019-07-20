Rails.application.routes.draw do

  # devise_for :users
   get "top" => "contents#top"
   get "top/:id" => "contents#topfolder"
   post "create" => "contents#create"
   post "update" => "contents#update"
   post "delete" => "contents#delete"
   post "folderdelete" => "contents#folderdelete"
   post "folder_manage_create" => "contents#folder_manage_create"
   post "folder_manage_delete" => "contents#folder_manage_delete"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
