module RokBlog
  class PostDrop < RokBase::BaseDrop
    def initialize(post)
      @object = post
    end

    def title
      @object.title
    end

    def content
      @object.content
    end

    def url
      # TODO: build this properly
      @object.slug
    end
  end
end
