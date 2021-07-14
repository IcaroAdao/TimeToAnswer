class Subject < ApplicationRecord
  has_many :questions 

  # Kaminari --- pagination gem
  paginates_per 10
end
