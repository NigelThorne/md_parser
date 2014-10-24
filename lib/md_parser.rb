require 'parslet'
require "md_parser/version"
require "md_parser/table_parser"
require "md_parser/hash_table_visitor"
require "md_parser/text_table_visitor"


module MdParser

  # MdParser.beautify_table("|A|B|\n|---|---|\n|1|2|")
  def beautify_table(table_text)
    TableTransformer.new.apply( 
      TableParser.new.parse( table_text ), 
        :visitor => TextTableVisitor.new)[:table_table]
  end
  module_function :beautify_table
    
  # MdParser.table_to_hash("|A|B|\n|---|---|\n|1|2|") 
  def table_to_hash(table_text)
    TableTransformer.new.apply( 
      TableParser.new.parse( table_text ), 
        :visitor => HashTableVisitor.new)[:table_table]
  end
  module_function :table_to_hash
end