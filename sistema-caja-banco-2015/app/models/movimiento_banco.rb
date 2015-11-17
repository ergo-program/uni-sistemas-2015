
class MovimientoBanco < ActiveRecord::Base
  belongs_to :cuentum
  belongs_to :motivo_movimiento_banco
  has_many :movimiento_banco_detalles


  validates :cuenta_id, :presence => {:message => "Seleccione una cuenta"}

  validates :monto_efectivo,  :presence => {:message => "No puede estar en blanco"},
                              :length => { in: 1..30 , message: "Debe tener entre 1 y 30 caracteres"},
                              :numericality => {:only_double => true, :message => "Debe ser un numero"}

  validates :monto_cheque,  :presence => {:message => "No puede estar en blanco"},
                            :length => { in: 1..30 , message: "Debe tener entre 1 y 30 caracteres"},
                            :numericality => {:only_double => true, :message => "Debe ser un numero"}

  validates :descripcion,  # :presence => {:message => "No puede estar en blanco"},
  #                         :length => { in: 8..50 , message: "Debe tener entre 8 y 50 caracteres"},
                           :format => {with: /[a-zA-ZÃ?ï¿½Ã?Â±Ã?Â¡Ã?Â©Ã?Â­Ã?Â³Ã?Âº]/, message: 'Solo permite letras'}


  before_create :crear_movimiento

  protected
  def crear_movimiento
  	self.fecha = Time.now
  	saldo = Cuentum.find(self.cuenta_id).saldo
    self.saldo_inicial = saldo
  	if self.es_ingreso
  		saldo= saldo + self.monto_efectivo + self.monto_cheque
  	else
  		saldo= saldo - self.monto_efectivo - self.monto_cheque
  	end
  	Cuentum.update(self.cuenta_id, :saldo => saldo)
  end
end

