class GenInfo::BirdEyeScoresController < ApplicationController
  before_action :set_bird_eye_score, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }
  # GET /bird_eye_scores
  def index
    @bird_eye_scores = BirdEyeScore.all.order(EffectiveDate: :desc)
    if params.keys.length < 1
      @bird_eye_scores = @bird_eye_scores.limit(100)
    end

    @bird_eye_scores = @bird_eye_scores.where(Co_serial: params[:Coserial]) if params[:Coserial].present?
    @bird_eye_scores = @bird_eye_scores.where("EffectiveDate > ?", Date.iso8601(params[:From])) if params[:From].present?
    @bird_eye_scores = @bird_eye_scores.where("EffectiveDate < ?", Date.iso8601(params[:To])) if params[:To].present?
    @bird_eye_scores = @bird_eye_scores.where("AvgerageRating < ?", params[:ReviewsUnder]) if params[:ReviewsUnder].present?
    @bird_eye_scores = @bird_eye_scores.where("AvgerageRating > ?", params[:ReviewsOver]) if params[:ReviewsOver].present?

    render json: @bird_eye_scores
  end

  # GET /bird_eye_scores/1
  def show
    render json: @bird_eye_score
  end

  # POST /bird_eye_scores
  def create
    @bird_eye_score = BirdEyeScore.new(bird_eye_score_params)

    if @bird_eye_score.save
      render json: @bird_eye_score, status: :created, location: @bird_eye_score
    else
      render json: @bird_eye_score.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bird_eye_score
    @bird_eye_score = BirdEyeScore.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bird_eye_score_params
    params.require(:bird_eye_score).permit(:EffectiveDate, :Co_serial, :ReviewCount, :AvgerageRating, :LastEdit_Who, :LastEdit_When)
  end
end
