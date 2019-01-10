class PemFilesController < ApplicationController
  before_action :set_pem_file, only: [:show, :edit, :update, :destroy]

  # GET /pem_files
  # GET /pem_files.json
  def index
    @pem_files = PemFile.all
  end

  # GET /pem_files/1
  # GET /pem_files/1.json
  def show
  end

  # GET /pem_files/new
  def new
    @pem_file = PemFile.new
  end

  # GET /pem_files/1/edit
  def edit
  end

  # POST /pem_files
  # POST /pem_files.json
  def create
    @pem_file = PemFile.new(pem_file_params)

    respond_to do |format|
      if @pem_file.save
        format.html { redirect_to @pem_file, notice: 'Pem file was successfully created.' }
        format.json { render :show, status: :created, location: @pem_file }
      else
        format.html { render :new }
        format.json { render json: @pem_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pem_files/1
  # PATCH/PUT /pem_files/1.json
  def update
    respond_to do |format|
      if @pem_file.update(pem_file_params)
        format.html { redirect_to @pem_file, notice: 'Pem file was successfully updated.' }
        format.json { render :show, status: :ok, location: @pem_file }
      else
        format.html { render :edit }
        format.json { render json: @pem_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pem_files/1
  # DELETE /pem_files/1.json
  def destroy
    @pem_file.destroy
    respond_to do |format|
      format.html { redirect_to pem_files_url, notice: 'Pem file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pem_file
      @pem_file = PemFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pem_file_params
      params.require(:pem_file).permit(:email, :status, :key, :cer)
    end
end
