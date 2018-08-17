require 'rails_helper'

RSpec.describe CourseStatsController do
  describe 'create' do
    it 'creates CourseStat with params' do
      expect do
        post :create, params: { course_stat: { score: 0, time_spent: 0} }
      end.to change(CourseStat, :count).by(1)
      expect(CourseStat.last.score).to eq(0)
      expect(CourseStat.last.time_spent).to eq(0)
    end
  end

  describe 'update' do
    it 'updates CourseStat with params' do
      course_stat = CourseStat.create(score: 0, time_spent: 0)
      patch :update, params: { course_stat: { score: 2, time_spent: 5}, id: course_stat.id }
      course_stat.reload
      expect(course_stat.score).to eq(2)
      expect(course_stat.time_spent).to eq(5)
    end
  end
end
