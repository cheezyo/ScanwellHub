class PackagePdf < Prawn::Document
  def initialize(package)
    super(top_margin: 30)
    @package = package
    @location =  Location.find(@package.origin)
    order_number
    #line_items
    
  end
  
  
    def order_number
     require 'open-uri'
     
     image open("http://bergents.org/wp-content/uploads/2012/03/Aker_Solutions_logo.jpg"),
     :width => 150, :height => 100, :at => [390, 765]
     text "Package \##{@package.pack_nr}", size: 30, style: :bold
     stroke_horizontal_rule
     move_down 20

     text_box @location.company.name + "\n " + @location.address + "\n " + @location.postal_code + " " + 
     @location.city + " \n" + @location.country.upcase,
     :at => [0, 650],
     :height => 100,
     :width => 300
      
      
     text_box @location.company.name + "\n " + @location.address + "\n " + @location.postal_code + " " + 
     @location.city + " \n" + @location.country.upcase,
     :at => [390, 650],
     :height => 100,
     :width => 300
     
     

  end
  
  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end


end