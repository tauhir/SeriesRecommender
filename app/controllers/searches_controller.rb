class SearchesController < ApplicationController
  before_action :set_search, only: [:edit, :update, :destroy, :show]

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search
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
    @search = Search.new({
      current_query: params[:query],
      user_id: user_signed_in? ? current_user.id : nil
    })
    if @search.save
      session[:current_search_id] = @search.id
    else
      raise Exception.new("no series series")
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    if @search
      @search.new_query({current_query: params[:query]})
      # self.show #render json: {search_id: @search.id}, status: :ok
    else
      render json: {}, status: :bad
    end
  end

  def update_or_create
    # search type states:
    # null == not pressed || no search id
    #  true ==  new search
    # false == continue search
    if params["search_type"] == "false" || (params["search_type"] == "null" && !session[:current_search_id].nil?)
      @search ||= Search.find_by(id: session[:current_search_id])
      update
    else
      create
    end
    redirect_to action: "show", id: @search.id
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: "Search was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # User thumbs up/thumbs downs a show
  # this should create a series list for likes or dislikes or append if
  # this call also determine whether to post to show action or respond to
  def opinion
    # TODO: check to see if the show is not liked/disliked and remove from that list
    @search = Search.find_by_id(params["searchId"])
    seriesId = params["seriesId"]
    type = params["liked"].eql?(true) ? "liked" : "disliked" # ruby changes boolean to string somehow, probably due to params? 2020-7-14 - THIS IS NOT A STRING ANYMORE
    series = SeriesList.find_by(search_id: @search.id, list_type: type)
    if series
      # append to series
      series.append(seriesId)
    else
      # create series list
      series = @search.create_series_list(seriesId, list_type: type)
    end
    render json: {search: @search}, status: :ok
  end

  def recommendations
    @series_list = Search.find_by(id: session[:current_search_id]).get_recommended
    render "searches/recommendations", locals: {recommended_list: @series_list}
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
