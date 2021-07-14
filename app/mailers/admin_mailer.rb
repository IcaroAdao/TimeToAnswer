class AdminMailer < ApplicationMailer
  def update_email(current_admin, changed_admin)
    @current_admin = current_admin
    @changed_admin = changed_admin
    
    mail(to: @changed_admin.email, subject: "Seus dados foram alterados")
  end
end
