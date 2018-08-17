class TaskStatsController < ApplicationController

  def create
    section_stat = SectionStat.find(params[:section_stat_id])
    task_stat = section_stat.task_stats.create(task_stat_params)
    render json: task_stat
  end

  def update
    task_stat = TaskStat.find(params[:id])
    task_stat.update!(task_stat_params)
    render json: task_stat
  end

  private
    def task_stat_params
      params.require(:task_stat).permit(:score, :time_spent)
    end
end
