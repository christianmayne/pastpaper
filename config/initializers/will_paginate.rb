class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end
  


class TwitterPaginationRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def next_page
      previous_or_next_page(@collection.next_page, "View More", 'twitter_pagination btn') if @collection.next_page
    end

    def pagination
      [ :next_page ]
    end

    # Override will_paginate's link method since it generates its own a
    # attribute and won't support :remote => true
    def link(text, target, attributes = {})
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end
      @template.link_to(text, target, attributes)
    end

  end

  def get_more_will_paginate(collection, id)
    will_paginate(collection, :renderer => "TwitterPaginationRenderer", :id => id, :class=>"morePagination")
  end
  