class CreateParrots < ActiveRecord::Migration
  def change
    create_table :parrots do |t|
      t.string     :name
      t.belongs_to :color,  index: true
      t.string     :sex
      t.integer    :age,    default: 0 # In months
      t.boolean    :tribal, default: false

      t.integer :mother_id
      t.integer :father_id

      t.timestamps null: false
    end
  end
end
