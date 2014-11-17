class PlansController < ApplicationController
    before_filter :possible_roles, only: [:new, :create]
    before_filter :possible_partnerships, only: [:new, :create]

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
            flash[:danger] = "Boo, Something went wrong"
            render :new
        end
    end

    private
    def plan_params
        params.require(:plan).permit(:role, :role_other, :partnerships, :scale, :opportunity, :timescale, :familiarity, :past_projects, :funding_how, :recruit_volunteers, :resources => [])
    end

    def possible_roles
        @possible_roles = ["architect", "resident", "business", "local government","community group", "politician", "arts group", "other"]
    end

    def possible_partnerships
        @possible_partnerships = ["No partnerships","architect", "resident", "community group", "politician", "arts group"]
    end

    def plan_output
        answers = []

        case @plan.timescale
        when 1
            answers.push({:title => "Timescale", :info => ["smaller scale suggestion", "Strict budget, no additional funding", "Suggest longer timescale"]})
        when 6
            answers.push({:title => "Timescale", :info => ["May be able to get aditional funding depending on timescale", "Enough time to engage multiple parties"]})
        when 12
            answers.push({:title => "Timescale", :info => ["Advise Long projects must have planned series on engagement in orfer to maintain interest", "Good chance to gain outside funding", "make sure to create string connections and relationships during this time", "Good amount of time to conduct large scale project"]})
        end

        case @plan.familiarity
        when "very"
            answers.push({:title => "Familiarity", :info => ["Make use of connections that you are likely to have"]})
        when "familiar"
            answers.push({:title => "Familiarity", :info => ["Suggest improving/building upon connections"]})
        when "unfamiliar"
            answers.push({:title => "Familiarity", :info => ["Creating new connections will be important to ensuring success", "Suggest smaller projects leading to more projects", "long time span will be necessary"]})
        end

        case @plan.past_projects
        when "yes"
            answers.push({:title => "Past Projects", :info => ["Research previous projects to understand success and failures", "be aware that those you are engaging may have consultation fatigue"]})
        when "no"
            answers.push({:title => "Past Projects", :info => ["Opportunity to impact upon area and create a great first impression"]})
        when "don\'t know"
            answers.push({ :title => "Past Projects", :info => ["Conduct further research to find out."]})
        end

        unless @plan.resources.include? "funding"
            if @plan.funding_how == false
                answers.push({:title => "Funding", :info => ["provide funding info"]})
            end
        end
        unless @plan.resources.include? "people"
            if @plan.recruit_volunteers == true
                answers.push({:title => "People", :info => ["Suggest methods to use to recruit people"]})
            else
                answers.push({:title => "People", :info => ["Question if they have necessary \"people power\""]})
            end
        end
        unless @plan.resources.include? "space"
            answers.push({:title => "Space", :info => ["You need a space for your project"]})
        end

        if @plan.partnerships == "no partnerships"
            answers.push({:title => "Partnerships", :info => ["You should consider making partnerships with Architects, Residents, Community groups, and politicians to increase connetivity in the area"]})
        else
            @partners = possible_roles
            @partners.delete(@plan.partnerships)
            message = "You should consider making partnerships with "
            @partners.each do |partner|
                message = message + partner + "s "
            end
            message = message + "as well as other " + @plan.partnerships + "s"
            answers.push({:title => "Partnerships", :info => [message]})
        end

        return answers
    end
end
