class MaterialStat < ApplicationRecord
  include Teachbase::MetrixCollector::BelongsToStat
  
  belongs_to_stat :section_stat, columns: %i[time_spent]
end
