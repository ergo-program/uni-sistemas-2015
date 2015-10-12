class CreateCuponEmitidos < ActiveRecord::Migration
  def change
    create_table :cupon_emitidos do |t|
      t.integer :nro_cupon
      t.decimal :monto
      t.date :fecha
      t.references :tarjeta, index: true
      t.string :concepto

      t.timestamps
    end
  end
end
