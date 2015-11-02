class MovimientoBanco < ActiveRecord::Base
  belongs_to :cuentum
  belongs_to :motivo_movimiento_banco


  validates :cuenta_id, :presence => {:message => "No puede estar en blanco"}

  validates :monto_efectivo,  :presence => {:message => "No puede estar en blanco"},
                              :length => {minimum: 1, :message => "Debe tener como minimo 6 caracteres"},
                              :length => {maximum: 30, :message => "Debe tener como maximo 20 caracteres"},
                              :numericality => {:only_double => true, :message => "Debe ser un numero"}

  validates :monto_cheque, :presence => {:message => "No puede estar en blanco"},
                            :length => {minimum: 1, :message => "Debe tener como minimo 6 caracteres"},
                            :length => {maximum: 30, :message => "Debe tener como maximo 20 caracteres"},
                            :numericality => {:only_double => true, :message => "Debe ser un numero"}

  validates :descripcion, :presence => {:message => "No puede estar en blanco"},
                          :length => {minimum: 8, :message => "Debe tener como minimo 6 caracteres"},
                          :length => {maximum: 50, :message => "Debe tener como maximo 20 caracteres"},
                          :format => {with: /[a-zA-ZÃ?ï¿½Ã?Â±Ã?Â¡Ã?Â©Ã?Â­Ã?Â³Ã?Âº]/, message: 'Solo permite letras'}


  before_create :create_movimiento

  protected
  def create_movimiento
  	self.fecha = Time.now
  	saldo = Cuentum.find(self.cuenta_id).saldo
  	if self.es_ingreso
  		saldo= saldo + self.monto_efectivo + self.monto_cheque
  	else
  		saldo= saldo - self.monto_efectivo - self.monto_cheque
  	end
  	Cuentum.update(self.cuenta_id, :saldo => saldo)
  end
end