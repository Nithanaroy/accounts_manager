class ApplicationController < ActionController::Base
	include ActionView::Helpers::NumberHelper
	protect_from_forgery

	before_filter :set_layout_variables

	def set_layout_variables
		@navigation_links = [
					{:controller => 'accounts', :content => 'Accounts'}, 
					{:controller => 'vendors', :content => 'Vendors'}, 
					{:controller => 'payments', :content => 'Payments'}, 
					{:controller => 'cheques', :content => 'Cheques'}]
	end
end
