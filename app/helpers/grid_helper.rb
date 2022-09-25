module GridHelper
  # def grid(grid)
  #   content_tag(:table) do
  #     content_tag(:tbody) do
  #       grid.cells.each_slice(Grid::SIZE) do |line|
  #         content_tag(:tr) do 
  #           line.each do |cell|
  #             content_tag(:td, "test")
  #           end
  #         end
  #       end
  #     end
  #   end
  # end

  def cell_class(cell)
    if cell.user.nil?
      "table-secondary"
    elsif cell.user == current_user
      "table-primary"
    else
      "table-danger"
    end
    
  end
  
end
