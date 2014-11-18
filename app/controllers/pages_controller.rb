class PagesController < ApplicationController

    def about

    end

    def dashboard
        @plans = Plan.all
    end
end
