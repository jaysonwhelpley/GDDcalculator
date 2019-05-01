class SentinelsController < ApplicationController
  before_action :set_sentinel, only: [:show, :edit, :update, :destroy]

  # GET /sentinels
  # GET /sentinels.json
  def index
    @sentinels = Sentinel.all
  end

  # GET /sentinels/1
  # GET /sentinels/1.json
  def show
  end

  # GET /sentinels/new
  def new
    @sentinel = Sentinel.new
  end

  # GET /sentinels/1/edit
  def edit
  end

  # POST /sentinels
  # POST /sentinels.json
  def create
    @sentinel = Sentinel.new(sentinel_params)

    respond_to do |format|
      if @sentinel.save
        format.html { redirect_to @sentinel, notice: 'Sentinel was successfully created.' }
        format.json { render :show, status: :created, location: @sentinel }
      else
        format.html { render :new }
        format.json { render json: @sentinel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sentinels/1
  # PATCH/PUT /sentinels/1.json
  def update
    respond_to do |format|
      if @sentinel.update(sentinel_params)
        format.html { redirect_to @sentinel, notice: 'Sentinel was successfully updated.' }
        format.json { render :show, status: :ok, location: @sentinel }
      else
        format.html { render :edit }
        format.json { render json: @sentinel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sentinels/1
  # DELETE /sentinels/1.json
  def destroy
    @sentinel.destroy
    respond_to do |format|
      format.html { redirect_to sentinels_url, notice: 'Sentinel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sentinel
      @sentinel = Sentinel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sentinel_params
      params.fetch(:sentinel, {})
    end
end
