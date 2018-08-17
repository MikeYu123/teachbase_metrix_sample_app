class MaterialStat < ApplicationRecord
  belongs_to_stat :section_stat, columns: %i[time_spent]
end
