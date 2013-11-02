module ComponentsHelper
  
  def get_comp_todos(comp)
    comp_todo = comp.comp_todos
    comp_todo_un_done = Array.new
    comp_todo.each do |c|
      if ! Todo.find(c.todo_id).done
        comp_todo_un_done << c
      end
    end    
    return comp_todo_un_done
  end
  
end
