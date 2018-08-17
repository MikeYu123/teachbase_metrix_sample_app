class TaskStat < ApplicationRecord
  include Teachbase::MetrixCollector::BelongsToStat
  
  belongs_to_stat :section_stat, columns: %i[score]

end
