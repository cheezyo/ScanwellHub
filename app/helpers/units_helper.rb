module UnitsHelper
 

  
  def get_total_todos(unit)
    total = 0
    unit_todos = unit.unit_todos
    
    unit_todos.each do |u|
      if ! Todo.find(u.todo_id).done
        total += 1
      end
    end
    components = unit.components
    
    components.each do |c|
      c.comp_todos.each do |ct|
        if ! Todo.find(ct.todo_id).done
          total += 1
        end
      end
    end
    return total
  end
  
  def get_total(unit)
    return get_todos_for_components_on_unit(unit).count + get_todos_for_unit(unit).count
  end
  def get_todos_for_components_on_unit(unit)
    components = unit.components
    comp_todo = Array.new
    
    components.each do |c|
      c.comp_todos.each do |ct|
        if ! Todo.find(ct.todo_id).done
         comp_todo << ct
        end
      end
  end 
      return comp_todo
  end
  
  def get_todos_for_unit(unit)
    unit_todos = unit.unit_todos
    unit_todos_un_done = Array.new
    
    unit_todos.each do |u|
      if ! Todo.find(u.todo_id).done
       unit_todos_un_done << u
      end
    end
    return unit_todos_un_done
  end


end
