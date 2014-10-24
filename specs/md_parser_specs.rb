require 'rspec'
require 'parslet/rig/rspec'
require "./parser"


describe TableParser  do
  let(:parser) { TableParser.new }
  
  context "#string" do
    it "should consume 'strings'" do
      expect( parser.string.parse('""') ) 
      expect( parser.string.parse('"test"') ) 
      expect( parser.string.parse('"multiple words"') ) 
      expect( parser.string.parse('" leading white space is fine "') ) 
      expect( parser.string.parse(%/" so is escaped \\" quotes "/) ) 
    end 
  end
  
  context "#cell" do
    it "should consume a cell" do
      expect( parser.cell.parse('||')[:table_value] ).to be_empty 
      expect( parser.cell.parse('|   |')[:table_value] ).to be_empty  
      expect( parser.cell.parse('| test  |')[:table_value] ).to eq "test"  
      expect( parser.cell.parse(' no leading pipe  |')[:table_value] ).to eq "no leading pipe"   
      expect( parser.cell.parse(' "can hold a string"  |')[:table_value] ).to eq "\"can hold a string\""  
      expect( parser.cell.parse(' "can hold a string containsing a |"  |')[:table_value] ).to eq "\"can hold a string containsing a |\"" 
      expect{ parser.cell.parse(' has to end in |  ') }.to raise_error 
    end
  end
  
  context "#separator_row" do
    it "should consume a separator_row" do
      expect( parser.separator_row.parse('|---|') )
      expect( parser.separator_row.parse('|---|---|') )
      expect( parser.separator_row.parse('---|---|') )
      expect( parser.separator_row.parse('---|---|---') )
      expect( parser.separator_row.parse('------|-----|-------') )
    end
  end
  
  context "#table" do
    it "should consume a table" do
      expect( parser.parse("|ID | Dependencies |\n|---|---|\n|1 | 2 |") )  
    end
  end
  
  context "#row" do
    it "should consume a row" do
      expect( parser.row.parse('| once cell |') )
      expect( parser.row.parse('| multiple | cells |') )
      expect( parser.row.parse(' multiple | cells      |') )
      expect( parser.row.parse(' multiple   | cells  |  ')[:table_row].map{|x| x[:table_value]} ).to eq ["multiple", "cells"]
      expect( parser.row.parse(' " this \" works"   | cells  |  ')[:table_row].map{|x| x[:table_value]} ).to eq ["\" this \\\" works\"", "cells"]
    end
  end
end

RSpec::Core::Runner.run([])