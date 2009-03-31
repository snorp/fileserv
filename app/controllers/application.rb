# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'b6ec4d57367093c60866e0e29e13804c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :set_path

  def set_path
    @path = ''
    @real_path = nil

    if params[:path] and params[:path] != '/'
      @path = params[:path].gsub(/^\//, '')

      share_root, share_path = @path.split('/', 2)
      if not share_path
        share_path = '/'
      end

      @real_path = File.expand_path(File.join(SHARES[share_root], share_path))
    end
  end
end
