class SeriesListsController < ApplicationController
  before_action :set_series_list, only: [:show, :edit, :update, :destroy]

  # GET /series_lists
  # GET /series_lists.json
  def index
    @series_lists = SeriesList.all
  end

  # GET /series_lists/1
  # GET /series_lists/1.json
  def show
  end

  # GET /series_lists/new
  def new
    @series_list = SeriesList.new
  end

  # GET /series_lists/1/edit
  def edit
  end

  # POST /series_lists
  # POST /series_lists.json
  def create
    @series_list = SeriesList.new(series_list_params)

    respond_to do |format|
      if @series_list.save
        format.html { redirect_to @series_list, notice: 'Series list was successfully created.' }
        format.json { render :show, status: :created, location: @series_list }
      else
        format.html { render :new }
        format.json { render json: @series_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /series_lists/1
  # PATCH/PUT /series_lists/1.json
  def update
    respond_to do |format|
      if @series_list.update(series_list_params)
        format.html { redirect_to @series_list, notice: 'Series list was successfully updated.' }
        format.json { render :show, status: :ok, location: @series_list }
      else
        format.html { render :edit }
        format.json { render json: @series_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /series_lists/1
  # DELETE /series_lists/1.json
  def destroy
    @series_list.destroy
    respond_to do |format|
      format.html { redirect_to series_lists_url, notice: 'Series list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_series_list
      @series_list = SeriesList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def series_list_params
      params.require(:series_list).permit(:api_id,, :name,language,origin_country)
    end
end
