class ConfiguracionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_configuracion, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @configuracions = Configuracion.all
    respond_with(@configuracions)
  end

  def show
    respond_with(@configuracion)
  end

  def new
    @configuracion = Configuracion.new
    respond_with(@configuracion)
  end

  def edit
  end

  def create
    @configuracion = Configuracion.new(configuracion_params)
    @configuracion.save
    respond_with(@configuracion)
  end

  def update
    respond_to do |format|
      if @configuracion.update(configuracion_params)
        format.html { redirect_to root_url, success: 'Las configuraciones se editaron correctamente.' }
        format.json { render :show, status: :ok, location: @configuracion }
      else
        format.html { render :edit }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @configuracion.destroy
    respond_with(@configuracion)
  end

  private
    def set_configuracion
      @configuracion = Configuracion.find(params[:id])
    end

    def configuracion_params
      params.require(:configuracion).permit(:nombre_empresa, :direccion, :correo, :telefono, :logo_empresa, :cabecera_impresion, :tiempo_espera)
    end
end
