class ColorsController < ApplicationController
  respond_to :json

  def index
    @colors = Color.all

    respond_with :api, @colors do |format|
      format.json do
        render layout: false
      end
    end
  end
end
