class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :phonetic_spelling
      t.string :email

      t.timestamps
    end

    add_index :people, :email, unique: true
  end
end
