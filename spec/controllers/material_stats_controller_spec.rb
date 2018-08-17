require 'rails_helper'

RSpec.describe MaterialStatsController do
  include ActiveJob::TestHelper
  ActiveJob::Base.queue_adapter = :test

  after :each do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe 'create' do
    it 'creates SectionStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      expect do
        post :create, params: { material_stat: { time_spent: 9}, course_stat_id: course_stat.id, section_stat_id: section_stat.id  }
      end.to change(MaterialStat, :count).by(1)
      expect(MaterialStat.last.time_spent).to eq(9)
    end

    it 'updates corresponding models' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      perform_enqueued_jobs do
        post :create, params: { material_stat: { time_spent: 5}, course_stat_id: course_stat.id, section_stat_id: section_stat.id }
      end
      course_stat.reload
      expect(course_stat.time_spent).to eq(5)
      section_stat.reload
      expect(section_stat.time_spent).to eq(5)
    end
  end

  describe 'update' do
    it 'updates SectionStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      material_stat = MaterialStat.create(time_spent: 0, section_stat_id: section_stat.id)
      patch :update, params: { material_stat: { time_spent: 5}, id: material_stat.id,
        course_stat_id: course_stat.id,
        section_stat_id: section_stat.id
      }
      material_stat.reload
      expect(material_stat.time_spent).to eq(5)
    end

    it 'updates corresponding models' do
      perform_enqueued_jobs do
        course_stat = CourseStat.create(score: 0, time_spent: 0)
        section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
        material_stat = MaterialStat.create(time_spent: 0, section_stat_id: section_stat.id)
        perform_enqueued_jobs do
          patch :update, params:
            {
              material_stat:
                {
                  time_spent: 8
                },
              id: material_stat.id,
              course_stat_id: course_stat.id,
              section_stat_id: section_stat.id
            }
        end
        course_stat.reload
        expect(course_stat.time_spent).to eq(8)
        section_stat.reload
        expect(section_stat.time_spent).to eq(8)
      end
    end
  end
end
