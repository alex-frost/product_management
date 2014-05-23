class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date
      t.float :vat
      t.string :status

      t.timestamps
    end
  end
end
