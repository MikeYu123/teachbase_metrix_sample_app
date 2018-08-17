class TaskStat < ApplicationRecord
  belongs_to_stat :section_stat, columns: %i[score]

end
