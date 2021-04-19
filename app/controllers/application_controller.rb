class ApplicationController < ActionController::Base
	before_action :set_locale
	
	include SessionsHelper


	private
	def set_locale
      locale = params[:locale].to_s.strip.to_sym
      return I18n.locale = locale if I18n.available_locales.include?(locale)
      
      I18n.locale = I18n.default_locale
    end
    
	def default_url_options
		{locale: I18n.locale}
	end

	def full_title page_title = ""
		base_title = "Ruby on Rails Tutorial Sample App"
		page_title.empty? ? base_title : "#{page_title} | #{base_title}"
	end

	private
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

end
