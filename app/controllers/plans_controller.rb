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
        when "Addressing Social Issues"
            small_workshop += 1
        when "Design and Construction"
            intervention_workshop += 1
        when "Improvement/Refurbishment"
            intervention_workshop += 1
        when "Masterplanning"
            small_workshop += 1
            intervention_workshop += 1
        when "New Build"
            intervention_workshop += 1
        when "Providing Access"
            intervention_workshop += 1
            art_workship += 1
        end

        case @plan.timescale
        when 1
            small_workshop += 1
            answers.push({:title => "Timescale", :info => ["Due to the short time constraints of your project it is vital you set clear targets and deadlines to ensure the necessary processes are undertaken. In order to create connections during this short time engagement must be focused, and participants clearly advised of the purpose and outcome."]})
        when 6
            intervention_workshop += 1
            art_workship += 1
            answers.push({:title => "Timescale", :info => ["Longer engagement can be achieved due to larger timescales. The majority of time should be spent preparing for the engagement, acquiring funding etc. If time allows, a smaller scale workshop could be conducted, this would increase your presence within the area prior to the main engagement."]})
        when 12
            intervention_workshop += 1
            art_workship += 1
            answers.push({:title => "Timescale", :info => ["As this project is going to run over a long time frame it is important to set achievable goals during this time, this will allow the project to continue developing and not stall unnecessarily. Longer projects allow for deeper connections to be formed during engagement. Longer time scales allow for multiple workshops to be conducted if possible."]})
        end

        case @plan.familiarity
        when "very"
            answers.push({:title => "Familiarity", :info => ["Use your great knowledge of the area to build upon existing connections."]})
        when "familiar"
            answers.push({:title => "Familiarity", :info => ["Consider conducted smaller workshops if time allows. This will help you develop connections with local stakeholders and gain a deeper understanding of the area."]})
        when "unfamiliar"
            small_workshop += 1
            answers.push({:title => "Familiarity", :info => ["Conduct smaller workshops if time allows. This will help you develop connections with local stakeholders and gain a deeper understanding of the area."]})
        end

        case @plan.past_projects
        when "yes"
            answers.push({:title => "Past Projects", :info => ["As previous projects have been conducted you should evaluate their successes and failures, this will help you improve your project. You should also be aware some participants may act negatively towards your project due to consultation fatigue. If so, ensure you are honest with your participants and conduct a workshop which engages on a more personal level than previously."]})
        when "no"
            answers.push({:title => "Past Projects", :info => ["As no previous projects have been conducted you have a chance to create a great first impression and impact upon the area."]})
        when "don\'t know"
            answers.push({ :title => "Past Projects", :info => ["Knowledge of previous projects which have been conducted in the area may influence your project. Understanding if they were successful, or not may offer opportunities to build upon or change the methods of previous engagement. Therefore you should consider researching if previous projects have been conducted."]})
        end

        unless @plan.resources.include? "funding"
            if @plan.funding_how == false
                answers.push({:title => "Funding", :info => ["The amount of funded required is determined by the scale of the engagement. When applying for funding it is important to compile a budget, this must be accurate being careful not to under or over estimate, as this could impact the success of the outcome.suggested Project: "]})
            end
        end
        unless @plan.resources.include? "people"
            if @plan.recruit_volunteers == true
                intervention_workshop += 1
                art_workship += 1
                answers.push({:title => "People", :info => ["Volunteers are vital to ensure your project is a success. Depending on the scale of your project you will likely need the assistance of volunteers. Local residents who have a strong investment within the project or participants from previous engagement would be ideal volunteers. Consider volunteers expenses within the budget."]})
            else
                small_workshop += 1
                answers.push({:title => "People", :info => ["Volunteers are vital to ensure your project is a success. Depending on the scale of your project you will likely need the assistance of volunteers. Local residents who have a strong investment within the project or participants from previous engagement would be ideal volunteers. Consider volunteers expenses within the budget."]})
            end
        end
        unless @plan.resources.include? "space"
            answers.push({:title => "Space", :info => ["You are likely to require a space to conduct the workshop, ideally this will be located at or near the space you are focusing on. If this is not possible then you could use a local community centre, alternatively you could consider a ‘roaming’ project which is able to move around. Be mindful to set aside a portion of the budget for hiring space if necessary."]})
        end

        if @plan.partnerships == ""
            answers.push({:title => "Partnerships", :info => ["If would be advisable to make the following connections to improve the success of your project: Architects, Residents, Local Businesses, Local Government, Community groups, Politicians and Arts groups."]})
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
                answers.push({:title => "Suggested Project : Small Workshop", :info => ["Small workshops can be conducted through a variety of methods, but the purpose should be to engage stakeholders within a two-way conversation, unlike traditional consultation which is generally one-way. Tasks such as: wishing trees, draw your neighbourhood, traffic light analysis are all suitable."] })
            when 1
                answers.push({:title => "Suggested Project : Architecture Workshop", :info => ["These workshops consist of engagement based around architectural centrepieces or models. Participants can be engaged through design and making."] })
            when 2
                answers.push({:title => "Suggested Project : Arts Workshop", :info => ["These workshops are led by artists who through the medium of art are able to engage conversations about issues or needs within an area. The work produced during the events does not have to represent the particular issues or needs, instead it is the conversations that take place simultaneously which are important. It is important."] })
            end
        end

        return answers
    end
end
