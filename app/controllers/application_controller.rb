class ApplicationController < ActionController::Base
    include SessionsHelper
    
    private
    
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        end
    end
    
    def login_user
        if logged_in?
            redirect_to groups_url
        end
    end
    
    def user_counts(user)
        @count_followings = user.followings.count
    end
    
    def group_counts(group)
        @count_connected = group.connected.count
    end
end
