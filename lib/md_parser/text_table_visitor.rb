module MdParser

  class TextTableVisitor

    def cell_widths(titles, rows)
      c = cols(titles, rows);
      c.map{|x| x.map{|y| y ? y.length : 0}.max}
    end
    
    def cols(titles, rows)
      titles.each.with_index.map{|t,i| [t] + rows.map{|r| r[i]} }
    end
    
    def pad_row(values, widths)
      "| "+ widths.zip(values).map{|w,v| v + ( " " * (w-v.length)) }.join(" | ") + " |"
    end

    def separator_row(widths)
      "|-"+ widths.map{|w| "-" * w }.join("-|-") + "-|"
    end
    
    def to_table(titles, rows)
      w = cell_widths(titles, rows)

      ( [ pad_row(titles, w), separator_row(w) ] + 
        rows.map{|r| pad_row(r, w)} ).join("\n")
    end

    def visit_table(titles, rows)
      to_table(titles, rows)
    end
  end

end
