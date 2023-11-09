class PhotosController < ApplicationController
  def index
    @photos = UnsplashService.search(params[:query]) if params[:query].present?
  end
end