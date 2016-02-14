class TranscodesController < ApplicationController
  before_action :set_transcode, only: [:show, :edit, :update, :destroy]

  # GET /transcodes
  # GET /transcodes.json
  def index
    @transcodes = Transcode.all
  end

  # GET /transcodes/1
  # GET /transcodes/1.json
  def show
  end

  # GET /transcodes/new
  def new
    @transcode = Transcode.new
  end

  # GET /transcodes/1/edit
  def edit
  end

  # POST /transcodes
  # POST /transcodes.json
  def create
    @transcode = Transcode.new(transcode_params)

    respond_to do |format|
      if @transcode.save
        format.html { redirect_to @transcode, notice: 'Transcode was successfully created.' }
        format.json { render :show, status: :created, location: @transcode }
      else
        format.html { render :new }
        format.json { render json: @transcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transcodes/1
  # PATCH/PUT /transcodes/1.json
  def update
    respond_to do |format|
      if @transcode.update(transcode_params)
        format.html { redirect_to @transcode, notice: 'Transcode was successfully updated.' }
        format.json { render :show, status: :ok, location: @transcode }
      else
        format.html { render :edit }
        format.json { render json: @transcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transcodes/1
  # DELETE /transcodes/1.json
  def destroy
    @transcode.destroy
    respond_to do |format|
      format.html { redirect_to transcodes_url, notice: 'Transcode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transcode
      @transcode = Transcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transcode_params
      params.require(:transcode).permit(:title, :general_option, :infile_option, :outfile_option, :extention)
    end
end
