class QuizStat < ApplicationRecord
  include Teachbase::MetrixCollector::BelongsToStat
  
  belongs_to_stat :section_stat, columns: %i[score time_spent]
  has_many :answer_stats, dependent: :destroy
end
