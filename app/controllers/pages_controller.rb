class PagesController < ApplicationController

    def home

    end

    def about

    end

    def projects

    end

    def dashboard
        unless admin_signed_in?
            flash[:danger] = "You need to be an admin user to view this page"
            redirect_to root_path
        end
        @plans = Plan.all.order('created_at DESC')
    end
end
