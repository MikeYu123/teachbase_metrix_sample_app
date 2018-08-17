class SectionStat < ApplicationRecord
  include Teachbase::MetrixCollector::BelongsToStat

  belongs_to_stat :course_stat, columns: %i[score time_spent]
end
