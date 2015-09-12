module RokBlog
  class PostDecorator < Draper::Decorator
    delegate_all

    def published_at
      helpers.content_tag :span, class: 'time' do
        object.published_at.strftime("%a %d/%m/%y") if published? && object.published_at.present?
      end
    end

    def published_rfc822
      object.published_at.to_s(:rfc822)
    end

    def published_gr
      object.published_at.strftime("%Y-%m-%dT%H:%M:%SZ")
    end

    def slug
      title.downcase.gsub(' ', '_')
    end
  end
end
