class PlanMailer < ActionMailer::Base
  default from: "\"Co Design Toolkit\" <newplan@codesigntoolkit.com>"

  def new_plan_email(plan, output)
    @plan = plan
    @output = output
    mail to: @plan.email, subject: "Your New Co Design Plan"
  end
end
