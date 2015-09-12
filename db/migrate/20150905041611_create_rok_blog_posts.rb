class CreateRokBlogPosts < ActiveRecord::Migration
  def change
    create_table :rok_blog_posts do |t|
      t.integer  "layout_id"
      t.string   "title"
      t.string   "slug"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "published",    default: false
      t.datetime "published_at"
    end

    add_index :rok_blog_posts, :layout_id
    add_index :rok_blog_posts, :slug
  end
end
