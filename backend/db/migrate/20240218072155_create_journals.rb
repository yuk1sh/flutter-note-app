class CreateJournals < ActiveRecord::Migration[7.1]
  def change
    create_table :journals do |t|
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
