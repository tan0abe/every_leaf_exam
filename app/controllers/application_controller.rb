class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger
end
