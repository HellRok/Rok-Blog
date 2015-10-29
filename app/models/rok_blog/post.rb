module RokBlog
  class Post < ActiveRecord::Base
    include PostExtension

    belongs_to :layout, class_name: 'RokCms::Layout'
    has_one :theme, through: :layout, class_name: 'RokCms::Theme'
    has_one :site, through: :layout, class_name: 'RokBase::Site'
    #has_many :comments

    before_save :set_published_at
    before_save :populate_path

    scope :published, -> { where(published: true) }
    scope :in_order, -> { order(published_at: :desc) }

    validates_presence_of :title, :slug, :layout_id, :content
    validates_uniqueness_of :title, :slug
    validates_length_of :title, :slug, maximum: 255

    def assets_updated_at
      [theme, site].map(&:updated_at).max
    end

    def set_published_at
      if published? && published_at.blank?
        self.published_at = DateTime.current
      elsif !published && published_at.present?
        self.published_at = nil
      end
    end

    def render
      filters = RokBase::LiquidFilters
      filters.set_site(site)

      Liquid::Template.parse(theme.render(layout.post)).render(
        {
          'site' => RokBase::SiteDrop.new(site),
          'page' => RokBlog::PostDrop.new(self)
        }, filters: [filters]
      )
    end

    private
      def populate_path
        self.path = [site.blog_base, slug].join ('/')
      end
  end
end
