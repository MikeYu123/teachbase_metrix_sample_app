require 'rails_helper'

RSpec.describe SectionStatsController do
  include ActiveJob::TestHelper
  ActiveJob::Base.queue_adapter = :test

  after :each do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe 'create' do
    it 'creates SectionStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      expect do
        post :create, params: { section_stat: { score: 6, time_spent: 7}, course_stat_id: course_stat.id  }
      end.to change(SectionStat, :count).by(1)
      expect(SectionStat.last.score).to eq(6)
      expect(SectionStat.last.time_spent).to eq(7)
    end

    it 'updates corresponding models' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      perform_enqueued_jobs do
        post :create, params: { section_stat: { score: 2, time_spent: 5}, course_stat_id: course_stat.id }
      end
      course_stat.reload
      expect(course_stat.score).to eq(2)
      expect(course_stat.time_spent).to eq(5)
    end
  end

  describe 'update' do
    it 'updates SectionStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      patch :update, params: { section_stat: { score: 2, time_spent: 5}, id: section_stat.id, course_stat_id: course_stat.id }
      section_stat.reload
      expect(section_stat.score).to eq(2)
      expect(section_stat.time_spent).to eq(5)
    end

    it 'updates corresponding models' do
      perform_enqueued_jobs do
        course_stat = CourseStat.create(score: 0, time_spent: 0)
        section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
        perform_enqueued_jobs do
          patch :update, params:
            {
              section_stat:
                {
                  score: 2,
                  time_spent: 5
                },
              id: section_stat.id,
              course_stat_id: course_stat.id
            }
        end
        course_stat.reload
        expect(course_stat.score).to eq(2)
        expect(course_stat.time_spent).to eq(5)
      end
    end
  end
end
