module ApplicationHelper
  
  def sortable(column, title = nil)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, {:sort => column, :direction => direction,:status_id => @status, :owner => @owner_id}, {:class => css_class}
  end

  def is_in_transit_unit(unit)
    
    log = unit.logunits.last
    if(log.status == RegisterTest2::Application::STATUS_IN_TRANSIT)
     return true
     else
       return false  
    end
  end

 def is_in_transit_comp(comp)
    
      log = comp.logcomponents.last
      if(log.status == RegisterTest2::Application::STATUS_IN_TRANSIT)
       return true
       else
         return false  
      end   
  end
  


end
