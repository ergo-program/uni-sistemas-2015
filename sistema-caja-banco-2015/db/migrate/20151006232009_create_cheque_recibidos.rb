class CreateChequeRecibidos < ActiveRecord::Migration
  def change
    create_table :cheque_recibidos do |t|
      t.integer :nro_cheque
      t.references :banco, index: true
      t.decimal :monto
      t.date :fecha
      t.string :concepto

      t.timestamps
    end
  end
end
