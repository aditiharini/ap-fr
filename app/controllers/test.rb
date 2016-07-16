require 'pdf/reader'
require 'open-uri'
require 'docsplit'
require 'pdftk'

    
  
filePath = 'http://media.collegeboard.com/digitalServices/pdf/ap/apcentral/ap13_frq_chemistry.pdf'
io     = open(filePath)
reader = PDF::Reader.new(io)
acidBase = false
solubility = false
        # puts reader.pdf_version
        # puts reader.info
        # puts reader.metadata
        # puts reader.page_count
pageNumber =0
# Docsplit.extract_pages('path/to/presentation.ppt')
# Docsplit.extract_pages('doc.pdf', :pages => 1..10)
Docsplit.extract_pages('../assets/pdf/chemsample.pdf', output:'../assets/pdf')
reader.pages.each do |page|
            # puts page.fonts
            
    pageText = page.text
    if(pageText=~ /[1-9]./)
        pageNumber=pageNumber+1
        text=""
        solubility = false
    end
    text += pageText
    if(text =~ /solubility(.*)/ )
        puts "contains solubility"
        solubility = true
    end
    
                
    
    
            # puts page.raw_content
puts text
puts solubility
end

        

    
    

