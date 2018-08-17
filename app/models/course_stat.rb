class CourseStat < ApplicationRecord
  has_many :section_stats, dependent: :destroy
end
