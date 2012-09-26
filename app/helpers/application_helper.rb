# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def site
    SiteProfile.first
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, ("add_fields(this, '#{association}', '#{escape_javascript(fields)}')"))
  end

  def people_gender
    [["Unknown", "Unknown"],["Male", "Male"], ["Female", "Female"]]
  end

  def banner_ads
    ['<a href="http://www.anrdoezrs.net/click-6185997-10660760" target="_top"><img src="http://www.ftjcfx.com/image-6185997-10660760" width="728" height="90" alt="728x90: Free trial" border="0"/></a>',
     '<a href="http://www.anrdoezrs.net/click-6185997-10660758" target="_top"><img src="http://www.lduhtrp.net/image-6185997-10660758" width="728" height="90" alt="728x90: Free trial" border="0"/></a>',
     '<a href="http://www.tkqlhce.com/click-6185997-10660751" target="_top"><img src="http://www.lduhtrp.net/image-6185997-10660751" width="728" height="90" alt="728x90: Free trial" border="0"/></a>',
     '<a href="http://www.anrdoezrs.net/click-6185997-10880818" target="_top"><img src="http://www.ftjcfx.com/image-6185997-10880818" width="728" height="90" alt="14 Day Free Trial " border="0"/></a>',
     '<a href="http://www.jdoqocy.com/click-6185997-10660719" target="_top"><img src="http://www.ftjcfx.com/image-6185997-10660719" width="728" height="90" alt="728x90_Genes Reunited" border="0"/></a>',
     '<a href="http://www.dpbolvw.net/click-6185997-10931192" target="_top"><img src="http://www.tqlkg.com/image-6185997-10931192" width="728" height="90" alt="" border="0"/></a>',
     '<a href="http://www.jdoqocy.com/click-6185997-10931171" target="_top"><img src="http://www.lduhtrp.net/image-6185997-10931171" width="728" height="90" alt="" border="0"/></a>',
     '<a href="http://www.kqzyfj.com/click-6185997-10931162" target="_top"><img src="http://www.tqlkg.com/image-6185997-10931162" width="728" height="90" alt="" border="0"/></a>']
  end

  def banner_ad
    return banner_ads[rand(banner_ads.count)].html_safe
  end

  
end
