class CreatePhoneBookItems < ActiveRecord::Migration
  def change
    create_table :phone_book_items do |t|
      t.string :full_name
      t.string :phone

      t.timestamps
    end
  end
end
