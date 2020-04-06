class SearchesController < ApplicationController
  before_action :set_search, only: [:edit, :update, :destroy]
  

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    
    if @search
      #this for when brought here locally
    else 
      byebug
    end
    # this should display the current search with recommended shows below
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new({:current_query => params[:query]})
    if @search.save
      # redirect_to "series_lists/#{@search.id}"
      # redirect_to :controller => series_lists 
      redirect_to series_list_path(@search.id)
    else
      raise Exception.new("no series series")
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # User thumbs up/thumbs downs a show
  # this should create a series list for likes or dislikes or append if
  # this call also determine whether to post to show action or respond to
  def opinion
    @search = Search.find_by_id(params["searchId"])
    seriesId = [params["seriesId"]]
    params["liked"].eql?("true") ? type = true : type = false #ruby changes boolean to string somehow, probably due to params?
    series = SeriesList.find_by(id: @search.id).try(:where, search_type: type) # shouldn't need first because there should only be one
    if series 
      #append to series
      series.external_series.append(seriesId)
    else
      #create series list
      series = @search.create_series_list(seriesId, search_type: type)
    end
    render json: {search: @search}, status: :ok
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def search_params
      
      params.require(:query)
    end
end
