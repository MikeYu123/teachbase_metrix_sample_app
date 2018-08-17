class QuizStatsController < ApplicationController

  def create
    section_stat = SectionStat.find(params[:section_stat_id])
    quiz_stat = section_stat.quiz_stats.create(quiz_stat_params)
    render json: quiz_stat
  end

  def update
    quiz_stat = QuizStat.find(params[:id])
    quiz_stat.update!(quiz_stat_params)
    render json: quiz_stat
  end

  private
    def quiz_stat_params
      params.require(:quiz_stat).permit(:score, :time_spent)
    end
end
