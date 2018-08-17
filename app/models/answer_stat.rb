class AnswerStat < ApplicationRecord
  belongs_to_stat :quiz_stat, columns: %i[score time_spent]

end
