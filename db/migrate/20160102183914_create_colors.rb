class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name, index: true, unique: true
      t.string :hex_value
    end
  end
end
