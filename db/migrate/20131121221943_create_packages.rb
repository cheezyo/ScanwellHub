class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :origin
      t.integer :destiantion
      t.date :arrival_date
      t.integer :reciver
      t.integer :status
      t.string :po
      t.string :ref
      t.text :coment
      t.string :pack_nr
      t.text :unit_ids
      t.text :components_ids

      t.timestamps
    end
  end
end
