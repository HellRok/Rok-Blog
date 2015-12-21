require_dependency "rok_blog/application_controller"

module RokBlog
  class PostsController < RokBase::ApplicationController
    load_and_authorize_resource :site, class: 'RokBase::Site'
    load_and_authorize_resource class: 'RokBlog::Post', through: :site, shallow: true
    decorates_assigned :posts, :post
    before_filter :set_site, :layout_crumbs, :stamp

    def index
      @posts = @posts.in_order
    end

    def new
    end

    def create
      if @post.save
        flash[:success] = @post.published? ?
          "#{@post.title} is now live!" :
          "#{@post.title} saved successfully."
        redirect_to site_posts_path(@site)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @post.update_attributes!(post_params)
        flash[:success] = "#{@post.title} has been updated."
        redirect_to site_posts_path(@site)
      else
        render :edit
      end
    end

    def preview
      # TODO: Make this work
      #@comment = Comment.new
      @post = RokBlog::Post.new
      @post.id = post_params[:id] || 1 # Dodgy but make the link work
      @post.title = post_params[:title]
      @post.content = post_params[:content]
      render 'posts/show', layout: 'application'
    end

    def destroy
      if @post.destroy
        flash[:success] = "#{@post.title} has been deleted."
        redirect_to site_posts_path(@site)
      else
        flash[:error] = @post.errors.full_messages.to_sentence
        redirect_to site_posts_path(@site)
      end
    end

    private
    def post_params
      params.require(:post).permit(:layout_id, :title, :slug, :content, :published)
    end

    def layout_crumbs
      add_crumb 'Blog Posts', site_posts_path(@site)

      if @post.present?
        if @post.persisted?
          add_crumb @post.title
          @title = @post.title
        else
          add_crumb 'New'
          @title = 'Blog Post'
        end
      end
    end
  end
end
