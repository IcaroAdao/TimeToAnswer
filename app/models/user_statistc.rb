class UserStatistc < ApplicationRecord
  belongs_to :user

  #Virtual attributes

  def total_questions
    self.right_questions + self.wrong_questions
  end

  def self.set_statistc(answer, current_user)
    if !!current_user
      user_statistc = UserStatistc.find_or_create_by(user: current_user)
      answer.correct? ? user_statistc.right_questions += 1 : user_statistc.wrong_questions += 1
      user_statistc.save!
    end
  end
end
