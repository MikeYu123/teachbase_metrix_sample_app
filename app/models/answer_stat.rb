class AnswerStat < ApplicationRecord
  include Teachbase::MetrixCollector::BelongsToStat
  
  belongs_to_stat :quiz_stat, columns: %i[score time_spent]

end
