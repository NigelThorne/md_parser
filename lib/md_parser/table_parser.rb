
module MdParser
  class TableParser < Parslet::Parser
      rule(:table)         { (( row.as(:table_titles)>>  separator_row ).maybe >>  
                             ( separator_row.absent? >> row ).repeat(1).as(:table_rows)).as(:table_table) }

      rule(:row)           { cell.repeat(1).as(:table_row) >> space? >> eol}
      rule(:separator_row) { str("|").maybe >> (str("-").repeat(3) >> str("|")).repeat(1) >> str("-").repeat(3).maybe >> eol}

      rule(:cell)          { str("|").maybe >> space? >> cell_body? >> space? >> str("|") }
      
      rule(:cell_body?)    { string.as(:table_value) | 
                             str('"').absent? >> ( 
                               str("|").absent? >> (
                                 (space >> str("|").absent?)|
                                 (space.absent? >> str("\n").absent? >> any)
                               )
                             ).repeat(0).as(:table_value) 
                           }
                           
      rule(:string)        { str('"') >> ( ( str('\\') >> any ) | ( str('"').absent? >> any ) ).repeat(0) >> str('"') }

      rule(:space)         { (str("\n").absent? >> match('\s')).repeat(1) }
      rule(:space?)        { space.maybe }
                             
      rule(:eof)           { any.absent? }                    
      rule(:eol)           { (str("\r").maybe >> str("\n")) | eof }   
      
      root :table
  end
  
  class TableTransformer < Parslet::Transform
    rule(:table_value  => [])                     { "" }
    rule(:table_value  => simple(:val))           { val.to_s }
    rule(:table_row    => sequence(:vals))        { vals }
    rule(:table_titles => sequence(:titles), 
         :table_rows   => subtree(:rows))         { visitor.visit_table(titles, rows) }
  end
  

end
