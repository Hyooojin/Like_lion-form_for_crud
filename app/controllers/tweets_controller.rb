class TweetsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # 무조건 로그인이 되었는지 확인
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  # 모든 함수에서 실행되는데 only에서만 실행시킬것
  def index
    @tweets = Tweet.order(id: :desc).page(params[:page]) # 최신글부터
    # @tweets = Tweet.order(:id).page(params[:page]) # 순서대로
  end

  def new
    @tweet = Tweet.new #한행을 비워서,
  end

  def create
  #   @tweet = Tweet.new(
  #     title: params[:tweet][:title],
  #     content: params[:tweet][:content]
  # )
  #   @tweet.save

  Tweet.create(tweet_params)

    # new, save의 이점은 나중에 update때 이해할 수 있다.
    redirect_to "/tweets"
  end

  def show
    set_tweet
    # @tweet = Tweet.find(params[:id])
  end

  def edit
    set_tweet
    # @tweet = Tweet.find(params[:id])

  end

  def update
    set_tweet
    # @tweet = Tweet.find(params[:id])

    # @tweet.update(
    #   title :params[:tweed][:title]
    #
    # )


    @tweet.update(tweet_params)
    redirect_to tweet_path @tweet
  end

  def destroy
    set_tweet()
    @tweet.destroy
    redirect_to '/tweets'
  end

  private
  def tweet_params
    # params 해쉬에 있는 것을 return! tweet라고 적혀있는 것을 하나하나 불러온다.
    return params.require(:tweet).permit(:title, :content, :user_id, :photo_url)
  end

  def set_tweet()
    @tweet = Tweet.find(params[:id])
  end
end
