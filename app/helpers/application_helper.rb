module ApplicationHelper

  def navigation_link(link_text, kontroller)
    content_tag :li, :class => kontroller.to_s == params[:controller] && 'active' || '' do 
      link_to link_text, kontroller
    end
  end

end
