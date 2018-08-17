class SectionStat < ApplicationRecord
  include Teachbase::MetrixCollector::BelongsToStat

  belongs_to_stat :course_stat, columns: %i[score time_spent]
  has_many :quiz_stats, dependent: :destroy
  has_many :material_stats, dependent: :destroy
  has_many :task_stats, dependent: :destroy

end
