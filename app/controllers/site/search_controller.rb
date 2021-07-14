class Site::SearchController < SiteController
  def questions
    @questions = Question.search(params[:term], params[:page])
  end

  def subject
    @questions = Question.search_subject(params[:subject_id], params[:page])
  end
end
