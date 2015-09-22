class AddPathToPosts < ActiveRecord::Migration
  def change
    add_column :rok_blog_posts, :path, :text
  end
end
