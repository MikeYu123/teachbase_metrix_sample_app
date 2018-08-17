class MaterialStatsController < ApplicationController

  def create
    section_stat = SectionStat.find(params[:section_stat_id])
    material_stat = section_stat.material_stats.create(material_stat_params)
    render json: material_stat
  end

  def update
    material_stat = MaterialStat.find(params[:id])
    material_stat.update!(material_stat_params)
    render json: material_stat
  end

  private
    def material_stat_params
      params.require(:material_stat).permit(:time_spent)
    end
end
