class AddTagsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tags, :text, array: true, default: []
  end
end
