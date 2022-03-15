class CreateTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :qualification
      t.integer :age
      t.string :sex

      t.timestamps
    end
  end
end
