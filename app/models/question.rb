class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Callback
  after_create :set_statistic

  # Kaminari --- pagination gem
  paginates_per 10

  scope :search, ->(term, page) {
    includes(:answers)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")
    .page(page)
  }

  scope :search_subject, ->(subject_id, page) {
    includes(:answers, :subject)
    .where(subject_id: subject_id)
    .page(page)
  }

  scope :return_questions_last_to_first, ->(page) {
    includes(:answers).order('created_at desc').page(page)
  }

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end
end
