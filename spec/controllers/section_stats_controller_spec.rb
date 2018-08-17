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
      expect do
        post :create, params: { course_stat: { score: 0, time_spent: 0} }
      end.to change(SectionStat, :count).by(1)
      expect(SectionStat.last.score).to eq(0)
      expect(SectionStat.last.time_spent).to eq(0)
    end

    it 'updates corresponding models' do
      perform_enqueued_jobs do
        course_stat = CourseStat.create(score: 0, time_spent: 0)
        post :create, params: { course_stat: { score: 2, time_spent: 5, course_stat_id: course_stat.id} }
        course_stat.reload
        expect(course_stat.score).to eq(2)
        expect(course_stat.time_spent).to eq(5)
      end
    end
  end

  describe 'update' do
    it 'updates SectionStat with params' do
      section_stat = SectionStat.create(score: 0, time_spent: 0)
      patch :update, params: { course_stat: { score: 2, time_spent: 5}, id: section_stat.id }
      section_stat.reload
      expect(section_stat.score).to eq(2)
      expect(section_stat.time_spent).to eq(5)
    end

    it 'updates corresponding models' do
      perform_enqueued_jobs do
        course_stat = CourseStat.create(score: 0, time_spent: 0)
        section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
        patch :update, params: { course_stat: { score: 2, time_spent: 5}, id: section_stat.id }
        course_stat.reload
        expect(course_stat.score).to eq(2)
        expect(course_stat.time_spent).to eq(5)
      end
    end
  end
end
