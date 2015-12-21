class AddBlogUserStamping < ActiveRecord::Migration
  def change
    add_column :rok_blog_posts, :creator_id, :integer
    add_column :rok_blog_posts, :updater_id, :integer
  end
end
