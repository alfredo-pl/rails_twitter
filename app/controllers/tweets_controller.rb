class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy]
  before_action :authenticate_user!, only: %i[ apinews apibetween]
  skip_before_action :verify_authenticity_token, only: %i[apiCreateTweet]
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: "hello", password: "world", only: %i[apiCreateTweet]

  # GET /tweets or /tweets.json
  def index
   # @tweets = Tweet.all.order(created_at: :desc).page(params[:page])
    @tweet = Tweet.new
   
    if current_user
        @q = Tweet.tweets_for_me(current_user).order(created_at: :desc).ransack(params[:q])
        @tweets = @q.result(distinct: true).page(params[:page])
      else

      @q = Tweet.all.order(created_at: :desc).ransack(params[:q])
      @tweets = @q.result(distinct: true).page(params[:page])
    end
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def hashtag
    @q = Tweet.all.order(created_at: :desc).ransack(params[:q])
    @tweets = @q.result.page(params[:page])
  end
  def apinews
    @tweets = Tweet.api_news
    render json: @tweets
  end

  def apibetween
    @q = Tweet.dates(params[:date1], params[:date2])
    @tweets = Tweet.frame(@q)
    render json: @tweets
  end

  def apiCreateTweet
    @tweet = Tweet.new(tweet_params)

      if @tweet.save
        render json: @tweet
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id, :tweet_id)
    end
end
