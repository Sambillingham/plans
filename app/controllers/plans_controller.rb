class PlansController < ApplicationController


    def new
        @plan = Plan.new
    end

    def show
        @partners = ["architect", "resident", "community group", "politician"]
        @plan = Plan.find(params[:id])
    end

    def create
        @plan = Plan.new(plan_params)
        if @plan.save
            flash[:success] = "Here is your suggested plan"
            redirect_to plan_path(@plan)
        else
            flash[:error] = "Boo, Something went wrong"
        end
    end

    private
    def plan_params
        params.require(:plan).permit(:role, :funding, :people, :space, :partnerships)
    end
end
