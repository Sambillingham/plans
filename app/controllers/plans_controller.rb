class PlansController < ApplicationController

    def index
        redirect_to new_plan_path
    end
    def new
        @plan = Plan.new
    end

    def show
        @plan = Plan.find(params[:id])
        @output = plan_output
    end

    def create
        @plan = Plan.new(plan_params)
        if @plan.save
            flash[:success] = "Here is your suggested plan"
            redirect_to plan_path(@plan)
        else
            flash[:error] = "Boo, Something went wrong"
            render :new
        end
    end

    private
    def plan_params
        params.require(:plan).permit(:role, :funding, :people, :space, :partnerships, :scale, :opportunity, :timescale, :familiarity, :past_projects)
    end

    def plan_output
        answers = []
        if @plan.funding == false
            answers.push("You need funding for your project")
        end
        if @plan.people == false
            answers.push("You need volunteers for your project")
        end
        if @plan.space ==
            answers.push("You need a space for your project")
        end

        if @plan.partnerships == "no partnerships"
            answers.push("You should consider making partnerships with Architects, Residents, Community groups, and politicians to increase connetivity in the area")
        else
            @partners = ["architect", "resident", "community group", "politician"]
            @partners.delete(@plan.partnerships)
            message = "You should consider making partnerships with "
            @partners.each do |partner|
                message = message + partner + "s "
            end
            message = message + "as well as other " + @plan.partnerships + "s"
            answers.push(message)
        end

        return answers
    end
end
