class PlanMailer < ActionMailer::Base
  default from: "\"Collaborative Design Toolkit\" <info@collaborativedesign.net>"

  def new_plan_email(plan, output)
    @plan = plan
    @output = output
    mail to: @plan.email, subject: "Your New Collaborative Design Plan"
  end
end
