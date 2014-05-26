class CreateVats < ActiveRecord::Migration
  def change
    create_table :vats do |t|
      t.float :amount, default: 0.2

      t.timestamps
    end
  end
end
