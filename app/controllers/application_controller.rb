class ApplicationController < ActionController::Base
  add_flash_types :alert

  before_action :set_logo_image
  
  def set_logo_image
    @photo_url = UnsplashService.fetch_random_logo
  end

  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end
end
