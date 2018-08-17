class CourseStatsController < ApplicationController

  def create
    course_stat = CourseStat.create(course_stat_params)
    render json: course_stat
  end

  def update
    course_stat = CourseStat.find(params[:id])
    course_stat.update!(course_stat_params)
    render json: course_stat
  end


  private
    def course_stat_params
      params.require(:course_stat).permit(:score, :time_spent)
    end
end
