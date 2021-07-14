class Site::WelcomeController < SiteController
  def index
    @questions = Question.return_questions_last_to_first(params[:page])
  end
end
