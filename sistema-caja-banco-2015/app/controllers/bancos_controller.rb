class BancosController < ApplicationController
  load_and_authorize_resource
  before_action :set_banco, only: [:show, :edit, :update, :destroy]

  # GET /bancos
  # GET /bancos.json
  def index
    @banco = Banco.new
    @bancos = Banco.all
    @pais = Pai.all

    @ciudads = Ciudad.all
    @pai = Pai.new
    @ciudad = Ciudad.new
  end

  # GET /bancos/1
  # GET /bancos/1.json
  def show
  end

  # GET /bancos/new
  def new
    @banco = Banco.new
    @bancos = Banco.all
    @pai = Pai.new
    @ciudad = Ciudad.new
  end

  # GET /bancos/1/edit
  def edit
    @bancos = Banco.all
    @pai = Pai.find(params[:id])
    @ciudad = Ciudad.find(params[:id])
    @pais = Pai.all
    @ciudads = Ciudad.all
  end

  # POST /bancos
  # POST /bancos.json
  def create
    @bancos = Banco.all
    @pais = Pai.all
    @ciudads = Ciudad.all
    @banco = Banco.new(banco_params)

    respond_to do |format|
      if @banco.save
        format.html { redirect_to bancos_url, success: 'Creaste un nuevo banco correctamente.' }
        format.json { render :show, status: :created, location: @banco }
      else
        format.html { render :new}
        format.json { render json: @banco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bancos/1
  # PATCH/PUT /bancos/1.json
  def update
    respond_to do |format|
      if @banco.update(banco_params)
        format.html { redirect_to bancos_url, success: 'Editaste un banco correctamente.' }
        format.json { render :show, status: :ok, location: @banco }
      else
        format.html { render :edit}
        format.json { render json: @banco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bancos/1
  # DELETE /bancos/1.json
  def destroy
    respond_to do |format|
      if @banco.destroy
        format.html { redirect_to bancos_url, success: 'Eliminaste un banco correctamente.' }
        format.json { head :no_content }
      else
        format.html { redirect_to bancos_url, danger: 'Se ha producido un error al eliminar.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banco
      @banco = Banco.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banco_params
      params.require(:banco).permit(:nombre, :direccion, :telefono, :correo, :sucursal, :ciudad_id, :pai_id)
    end
end

