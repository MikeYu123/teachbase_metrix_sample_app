class SectionStatsController < ApplicationController

  def create
    section_stat = SectionStat.create(section_stat_params)
    render json: section_stat
  end

  def update
    section_stat = SectionStat.find(params[:id])
    section_stat.update!(section_stat_params)
    render json: section_stat
  end

  private
    def section_stat_params
      params.require(:section_stat).permit(:score, :time_spent, :course_stat_id)
    end
end
