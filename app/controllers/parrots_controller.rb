class ParrotsController < ApplicationController
  respond_to :json

  def index
    # TODO Below code is not ideal, needs optimizing
    begin

      p = Parrot.all # I could use @parrots everywhere, but 'p' is shorter for bunch of selects

      [:ancestors, :descendants, :children, :parents].each do |selector|
        (p = p & Parrot.find(params[selector].to_i).try(selector)) if params[selector]
      end

      # Temporary solution for nil elements within 'p' when wrong 'selector' ids given
      p.each { |_p| p.delete _p if _p.nil? } if p

      (p = p.select { |_p| _p.age    >= params[:age_min].to_i }) if params[:age_min]
      (p = p.select { |_p| _p.age    <= params[:age_max].to_i }) if params[:age_max]
      (p = p.select { |_p| _p.sex    == params[:sex] })          if params[:sex]
      (p = p.select { |_p| _p.id     == params[:id].to_i })      if params[:id]
      (p = p.select { |_p| _p.tribal == (params[:tribals] == 'true' || params[:tribal] == true) }) unless params[:tribals].nil?
      (p = p.select { |_p| _p.color  == Color.find_by_name(params[:color]) })   unless params[:color].blank?
      (p = p.select { |_p| _p.name.downcase.include?(params[:name].downcase) }) unless params[:name].blank?

      @parrots = p

    rescue Exception => e
      @error = e
    end

    respond_to do |format|
      format.json do
        render layout: false, status: (@error ? :unprocessable_entity : :ok)
      end
    end
  end

  def update
    begin
      @parrot = Parrot.find(params[:id].to_i)
      @parrot.update_attributes(update_parrot_params)
    rescue Exception => e
      @error = e
    end

    respond_to do |f|
      f.json do
        render layout: false, status: (@error ? :unprocessable_entity : :ok)
      end
    end
  end

  def create
    begin
      @parrot = Parrot.create!(create_parrot_params)
    rescue Exception => e
      @error = e
    end

    respond_to do |f|
      f.json do
        render layout: false, status: (@error ? :unprocessable_entity : :ok)
      end
    end
  end

  private
    def create_parrot_params
      params.require(:parrot).permit(:name, :sex, :color_id, :tribal, :age, :mother_id, :father_id)
    end

    def update_parrot_params
      params.require(:parrot).permit(:tribal)
    end
end
