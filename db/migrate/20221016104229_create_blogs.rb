class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.text :content
      t.string :image
      t.timestamps
    end
  end
end
