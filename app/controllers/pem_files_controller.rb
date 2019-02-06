class PemFilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_pem_file, only: [:show, :edit, :update, :destroy]

  # GET /pem_files
  # GET /pem_files.json
  def index
    @pem_file = PemFile.where(email: session[:user_email]).where(status: PemFile::ACTIVE).last
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
    require 'openssl'
    password = params[:password]
    prefix_file_name = session[:user_email].split('@').first
    key_temp = Rails.root.join(pem_file_params[:private_key].tempfile)
    cer_temp = Rails.root.join(pem_file_params[:public_key].tempfile)
    key_success = system "openssl pkcs8 -inform DER -in #{key_temp} -out public/#{prefix_file_name}_open.key.pem -passin pass:#{password}"
    key_success = system "openssl rsa -in public/#{prefix_file_name}_open.key.pem -out public/#{prefix_file_name}.key.pem -aes256 -passout pass:#{password}"
    cer_success = system "openssl x509 -inform DER -outform PEM -in #{cer_temp} -pubkey > public/#{prefix_file_name}.cer.pem"
    if key_success && cer_success
      @pem_file = PemFile.new(
      private_key_open:File.read("public/#{prefix_file_name}_open.key.pem"),
      private_key:File.read("public/#{prefix_file_name}.key.pem"),
      public_key:File.read("public/#{prefix_file_name}.cer.pem"),
      email: session[:user_email]
      )
      if @pem_file.save
        redirect_to root_path, notice: 'PEM creado exitósamente'
      else
        redirect_to root_path, alert: 'Asegúrese que la contraseña corresponda a los archivos'
      end
    else
      redirect_to root_path, alert: 'Asegúrese que la contraseña corresponda a los archivos'
    end
    system "rm #{Rails.root.join("public","#{prefix_file_name}*")}"
  end

  # PATCH/PUT /pem_files/1
  # PATCH/PUT /pem_files/1.json
  def update
    respond_to do |format|
      if @pem_file.update(pem_file_params)
        format.html {redirect_to @pem_file, notice: 'Se actualizó el PEM'}
        format.json {render :show, status: :ok, location: @pem_file}
      else
        format.html {render :edit}
        format.json {render json: @pem_file.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /pem_files/1
  # DELETE /pem_files/1.json
  def destroy
    @pem_file.update(status: PemFile::DELETED)
    respond_to do |format|
      format.html {redirect_to pem_files_url, notice: 'Se eliminaron los archivos PEM'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pem_file
    @pem_file = PemFile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pem_file_params
    params.require(:pem_file).permit(:email, :status, :private_key, :public_key)
  end

end
