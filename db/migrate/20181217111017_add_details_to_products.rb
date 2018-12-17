class AddDetailsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :content, :text
    add_column :products, :progress, :string
  end
end
