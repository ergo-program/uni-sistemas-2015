class CuentaController < ApplicationController
  load_and_authorize_resource
  before_action :set_cuentum, only: [:show, :edit, :update, :destroy]

  # GET /cuenta
  # GET /cuenta.json
  def index
    @cuenta = Cuentum.all
    @cuentum = Cuentum.new
  end

  # GET /cuenta/1
  # GET /cuenta/1.json
  def show
    @cuenta = Cuentum.all
    @cuentum = Cuentum.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CuentumPdf.new([@cuentum, current_user.username], view_context)
        send_data pdf.render, filename: "libro_banco_#{@cuentum.nro_cuenta}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /cuenta/new
  def new
    @cuentum = Cuentum.new
  end

  # GET /cuenta/1/edit
  def edit
    @cuenta = Cuentum.all
  end

  # POST /cuenta
  # POST /cuenta.json
  def create
    @cuenta = Cuentum.all
    @cuentum = Cuentum.new(cuentum_params)

    respond_to do |format|
      if @cuentum.save
        format.html { redirect_to @cuentum, notice: 'Cuentum was successfully created.' }
        format.json { render :show, status: :created, location: @cuentum }
      else
        format.html { render :new }
        format.json { render json: @cuentum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cuenta/1
  # PATCH/PUT /cuenta/1.json
  def update
    respond_to do |format|
      if @cuentum.update(cuentum_params)
        format.html { redirect_to cuenta_url, notice: 'Cuentum was successfully updated.' }
        format.json { render :show, status: :ok, location: @cuentum }
      else
        format.html { render :edit }
        format.json { render json: @cuentum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuenta/1
  # DELETE /cuenta/1.json
  def destroy
    @cuentum.destroy
    respond_to do |format|
      format.html { redirect_to cuenta_url, notice: 'Cuentum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cuentum
      @cuentum = Cuentum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cuentum_params
      params.require(:cuentum).permit(:nro_cuenta, :saldo, :banco_id, :chequeras_attributes => [:id, :nro_primero, :nro_ultimo, :personal_id, :_destroy], :credits_attributes => [:id, :nro_tarjeta, :personal_id, :_destroy])
    end
end
