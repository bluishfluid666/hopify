class ApplicationController < ActionController::Base
  include SessionsHelper
  def execute_statement(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)
  
    if results.present?
      return results
    else
      return nil
    end
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to root_url, status: :see_other
    end
  end
end
