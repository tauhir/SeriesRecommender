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
      @search = Search.find_by(id: params[:id])
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
      # session[:search_id] = @search.id
      cookies[:search_id] = @search.id
      cookies[:last_query_time] = Time.now
      render json: {search_id: @search.id}, status: :ok
    else
      raise Exception.new("no series series")
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    if @search
      @search.new_query({:current_query => params[:query]})
      cookies[:last_query_time] = Time.now
      render json: {search_id: @search.id}, status: :ok
    else
      render json: {}, status: :bad
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
  
  def has_session
    
    state = "no_session"
    id = nil
    if cookies[:last_query_time] && Time.now-cookies[:last_query_time] < 12 # this checks to see if the user was on the system in the last 12 hours, maybe should make it less
      state = "active_session"
    elsif cookies[:search_id]
      state = "inactive_session"
    end 
    render json: {session_status: state, id: cookies[:search_id], }, status: :ok
  end
  # User thumbs up/thumbs downs a show
  # this should create a series list for likes or dislikes or append if
  # this call also determine whether to post to show action or respond to
  def opinion
    # TODO: check to see if the show is not liked/disliked and remove from that list
    @search = Search.find_by_id(params["searchId"])
    seriesId = params["seriesId"]
    params["liked"].eql?(true) ? type = "liked" : type = "disliked" #ruby changes boolean to string somehow, probably due to params? 2020-7-14 - THIS IS NOT A STRING ANYMORE
    series = SeriesList.find_by(search_id: @search.id, list_type: type)
    if series 
      #append to series
      series.append(seriesId)
    else
      #create series list
      series = @search.create_series_list(seriesId, list_type: type)
    end
    cookies[:last_query_time] = Time.now
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
