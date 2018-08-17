class SectionStatsController < ApplicationController

  def create
    course_stat = CourseStat.find(params[:course_stat_id])
    section_stat = course_stat.section_stats.create(section_stat_params)
    render json: section_stat
  end

  def update
    section_stat = SectionStat.find(params[:id])
    section_stat.update!(section_stat_params)
    render json: section_stat
  end

  private
    def section_stat_params
      params.require(:section_stat).permit(:score, :time_spent)
    end
end
