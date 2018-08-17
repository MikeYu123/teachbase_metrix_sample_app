require 'rails_helper'

RSpec.describe AnswerStatsController do
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
      quiz_stat = QuizStat.create(score: 0, time_spent: 0, section_stat: section_stat)
      expect do
        post :create, params: { answer_stat: { score: 3, time_spent: 9},
          course_stat_id: course_stat.id, section_stat_id: section_stat.id,
          quiz_stat_id: quiz_stat.id }
      end.to change(AnswerStat, :count).by(1)
      expect(AnswerStat.last.score).to eq(3)
      expect(AnswerStat.last.time_spent).to eq(9)
    end

    it 'updates corresponding models' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      quiz_stat = QuizStat.create(score: 0, time_spent: 0, section_stat: section_stat)

      perform_enqueued_jobs do
        post :create, params: { answer_stat: { score: 2, time_spent: 5},
        course_stat_id: course_stat.id, section_stat_id: section_stat.id,
        quiz_stat_id: quiz_stat.id }
      end
      course_stat.reload
      expect(course_stat.score).to eq(2)
      expect(course_stat.time_spent).to eq(5)
      section_stat.reload
      expect(section_stat.score).to eq(2)
      expect(section_stat.time_spent).to eq(5)
      quiz_stat.reload
      expect(quiz_stat.score).to eq(2)
      expect(quiz_stat.time_spent).to eq(5)
    end
  end

  describe 'update' do
    it 'updates SectionStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
      quiz_stat = QuizStat.create(score: 0, time_spent: 0, section_stat: section_stat)
      answer_stat = AnswerStat.create(score: 0, time_spent: 0, quiz_stat_id: quiz_stat.id)
      patch :update, params: { answer_stat: { score: 2, time_spent: 5}, id: answer_stat.id,
        course_stat_id: course_stat.id,
        section_stat_id: section_stat.id,
        quiz_stat_id: quiz_stat.id
      }
      answer_stat.reload
      expect(answer_stat.score).to eq(2)
      expect(answer_stat.time_spent).to eq(5)
    end

    it 'updates corresponding models' do
      perform_enqueued_jobs do
        course_stat = CourseStat.create(score: 0, time_spent: 0)
        section_stat = SectionStat.create(score: 0, time_spent: 0, course_stat: course_stat)
        quiz_stat = QuizStat.create(score: 0, time_spent: 0, section_stat: section_stat)
        answer_stat = AnswerStat.create(score: 0, time_spent: 0, quiz_stat_id: quiz_stat.id)
        perform_enqueued_jobs do
          patch :update, params:
            {
              answer_stat:
                {
                  score: 6,
                  time_spent: 8
                },
              id: answer_stat.id,
              course_stat_id: course_stat.id,
              section_stat_id: section_stat.id,
              quiz_stat_id: quiz_stat.id
            }
        end
        course_stat.reload
        expect(course_stat.score).to eq(6)
        expect(course_stat.time_spent).to eq(8)
        section_stat.reload
        expect(section_stat.score).to eq(6)
        expect(section_stat.time_spent).to eq(8)
        quiz_stat.reload
        expect(quiz_stat.score).to eq(6)
        expect(quiz_stat.time_spent).to eq(8)
      end
    end
  end
end
