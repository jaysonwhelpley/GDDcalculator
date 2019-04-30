class WeatherRecordsController < ApplicationController
  before_action :set_weather_record, only: [:show, :edit, :update, :destroy]

  # GET /weather_records
  # GET /weather_records.json
  def index
    @weather_records = WeatherRecord.all
  end

  # GET /weather_records/1
  # GET /weather_records/1.json
  def show
  end

  # GET /weather_records/new
  def new
    @weather_record = WeatherRecord.new
  end

  # GET /weather_records/1/edit
  def edit
  end

  # POST /weather_records
  # POST /weather_records.json
  def create
    @weather_record = WeatherRecord.new(weather_record_params)

    respond_to do |format|
      if @weather_record.save
        format.html { redirect_to @weather_record, notice: 'Weather record was successfully created.' }
        format.json { render :show, status: :created, location: @weather_record }
      else
        format.html { render :new }
        format.json { render json: @weather_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_records/1
  # PATCH/PUT /weather_records/1.json
  def update
    respond_to do |format|
      if @weather_record.update(weather_record_params)
        format.html { redirect_to @weather_record, notice: 'Weather record was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_record }
      else
        format.html { render :edit }
        format.json { render json: @weather_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_records/1
  # DELETE /weather_records/1.json
  def destroy
    @weather_record.destroy
    respond_to do |format|
      format.html { redirect_to weather_records_url, notice: 'Weather record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_record
      @weather_record = WeatherRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_record_params
      params.fetch(:weather_record, {})
    end
end
