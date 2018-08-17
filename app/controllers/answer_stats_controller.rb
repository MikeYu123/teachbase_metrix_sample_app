class AnswerStatsController < ApplicationController
  def create
    quiz_stat = QuizStat.find(params[:quiz_stat_id])
    answer_stat = quiz_stat.answer_stats.create(answer_stat_params)
    render json: answer_stat
  end

  def update
    answer_stat = AnswerStat.find(params[:id])
    answer_stat.update!(answer_stat_params)
    render json: answer_stat
  end

  private
    def answer_stat_params
      params.require(:answer_stat).permit(:score, :time_spent)
    end
end
