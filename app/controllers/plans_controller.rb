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

        unless @plan.email.blank?
            if @plan.email_user_plan and @plan.email_sent == false
                PlanMailer.new_plan_email(@plan, @output).deliver
                @plan.email_sent = true
                @plan.save
            end
        end
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
        params.require(:plan).permit(:role, :role_other,{:partnerships => []}, :scale, :opportunity, :timescale, :familiarity, :past_projects, :funding_how, :recruit_volunteers, { :resources => []}, :name, :email, :email_user_plan)
    end

    def possible_roles
        @possible_roles = ["architect", "resident", "business", "local government","community group", "politician", "arts group", "artist", "other"]
    end

    def possible_partnerships
        @possible_partnerships = ["architect", "resident", "local business", "local government", "community group", "politician", "arts group"]
    end

    def plan_output
        answers = []
        small_workshop = 0
        intervention_workshop = 0
        art_workship = 0

        case @plan.opportunity
        when "Addressing Safety", "Questioning Policy"
            small_workshop += 1
        when "Engaging Stakeholders"
            intervention_workshop += 1
            art_workship += 1
        end

        case @plan.timescale
        when 1
            small_workshop += 1
            answers.push({:title => "Timescale", :info => ["smaller scale suggestion", "Strict budget, no additional funding", "Suggest longer timescale"]})
        when 6
            intervention_workshop += 1
            art_workship += 1
            answers.push({:title => "Timescale", :info => ["May be able to get aditional funding depending on timescale", "Enough time to engage multiple parties"]})
        when 12
            intervention_workshop += 1
            art_workship += 1
            answers.push({:title => "Timescale", :info => ["Advise Long projects must have planned series on engagement in orfer to maintain interest", "Good chance to gain outside funding", "make sure to create string connections and relationships during this time", "Good amount of time to conduct large scale project"]})
        end

        case @plan.familiarity
        when "very"
            answers.push({:title => "Familiarity", :info => ["Make use of connections that you are likely to have"]})
        when "familiar"
            answers.push({:title => "Familiarity", :info => ["Suggest improving/building upon connections"]})
        when "unfamiliar"
            small_workshop += 1
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
                intervention_workshop += 1
                art_workship += 1
                answers.push({:title => "People", :info => ["Suggest methods to use to recruit people"]})
            else
                small_workshop += 1
                answers.push({:title => "People", :info => ["Question if they have necessary \"people power\""]})
            end
        end
        unless @plan.resources.include? "space"
            answers.push({:title => "Space", :info => ["You need a space for your project"]})
        end

        if @plan.partnerships == ""
            answers.push({:title => "Partnerships", :info => ["You should consider making partnerships with Architects, Residents, Community groups, and politicians to increase connetivity in the area"]})
        else
            @partners = possible_partnerships - @plan.partnerships
            answers.push({:title => "Partnerships", :info => @partners })

            if @plan.partnerships.include? "architect"
                intervention_workshop += 1
                art_workship += 1
            end
        end

        case @plan.role
        when "architect"
            intervention_workshop += 1
        when "artist"
            art_workship += 1
        end

        projects = [ small_workshop, intervention_workshop, art_workship]

        # Testing scores for each
        # projects.each_with_index do |val, index|
        #     case index
        #     when 0
        #         answers.push({:title => "Small Workshop", :info => ["Score: #{val}"] })
        #     when 1
        #         answers.push({:title => "Architecture Workshop", :info => ["Score: #{val}"] })
        #     when 2
        #         answers.push({:title => "Arts Workshop", :info => ["Score: #{val}"] })
        #     end
        # end

        max = projects.each_index.select { |i| projects[i] == projects.max }

        max.each do |project|
            # loop over the result with the biggest score incase multiple match
            case project
            when 0
                answers.push({:title => "Small Workshop", :info => ["info... Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eaque vitae facere earum, ratione ducimus officia cupiditate odio illum sunt. Tempore nihil sint fuga quos suscipit voluptatum molestias explicabo. Excepturi, vero!"] })
            when 1
                answers.push({:title => "Architecture Workshop", :info => ["info... Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut et pariatur commodi quos praesentium, saepe facere illo expedita consectetur porro eaque incidunt. Blanditiis perspiciatis quod repellendus, doloremque esse, inventore vero."] })
            when 2
                answers.push({:title => "Arts Workshop", :info => ["info... Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium et, dolore, fugiat placeat iure eligendi voluptas vero at delectus quaerat debitis, praesentium quae tempora cupiditate quidem! Quisquam quia aliquid, magni!"] })
            end
        end

        return answers
    end
end
