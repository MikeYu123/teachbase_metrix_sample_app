require 'rails_helper'

RSpec.describe TaskStatsController do
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
        post :create, params: { task_stat: { score: 3}, course_stat_id: course_stat.id, section_stat_id: section_stat.id  }
      end.to change(TaskStat, :count).by(1)
      expect(TaskStat.last.score).to eq(3)
    end

    it 'updates corresponding models' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      perform_enqueued_jobs do
        post :create, params: { task_stat: { score: 2}, course_stat_id: course_stat.id, section_stat_id: section_stat.id }
      end
      course_stat.reload
      expect(course_stat.score).to eq(2)
      section_stat.reload
      expect(section_stat.score).to eq(2)
    end
  end

  describe 'update' do
    it 'updates SectionStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      task_stat = TaskStat.create(score: 0, section_stat_id: section_stat.id)
      patch :update, params: { task_stat: { score: 2}, id: task_stat.id,
        course_stat_id: course_stat.id,
        section_stat_id: section_stat.id
      }
      task_stat.reload
      expect(task_stat.score).to eq(2)
    end

    it 'updates corresponding models' do
      perform_enqueued_jobs do
        course_stat = CourseStat.create(score: 0, time_spent: 0)
        section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
        task_stat = TaskStat.create(score: 0, section_stat_id: section_stat.id)
        perform_enqueued_jobs do
          patch :update, params:
            {
              task_stat:
                {
                  score: 6,
                },
              id: task_stat.id,
              course_stat_id: course_stat.id,
              section_stat_id: section_stat.id
            }
        end
        course_stat.reload
        expect(course_stat.score).to eq(6)
        section_stat.reload
        expect(section_stat.score).to eq(6)
      end
    end
  end
end
