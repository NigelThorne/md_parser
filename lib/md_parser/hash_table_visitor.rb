module MdParser

  class HashTableVisitor
    def table_to_h(titles, rows)
      rows.map{|row| row.each.with_index.each_with_object({}){|(cell, index), h| h[titles[index]] = cell}} 
    end
    
    def visit_table(titles, rows)
      table_to_h(titles, rows)
    end
  end

end