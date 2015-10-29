module RokBlog
  class PostDrop < RokBase::BaseDrop
    def initialize(post)
      @object = post
    end

    def title
      @object.title
    end

    def content
      filters = RokBase::LiquidFilters
      filters.set_site(@object.site)

      Liquid::Template.parse(@object.content).render(
        {
          'site' => RokBase::SiteDrop.new(@object.site),
          'page' => self
        }, filters: [filters]
      )
    end

    def url
      # TODO: build this properly
      @object.slug
    end
  end
end
