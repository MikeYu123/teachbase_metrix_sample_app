class QuizStat < ApplicationRecord
  belongs_to_stat :section_stat, columns: %i[score time_spent]
end
