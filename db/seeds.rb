# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'pdf/reader'
require 'open-uri'
require 'docsplit'
require 'pdftk'
require 'rubygems'
require 'nokogiri'
# require 'gs'
bothLinks = ['http://apcentral.collegeboard.com/apc/public/exam/exam_information/221837.html','http://apcentral.collegeboard.com/apc/members/exam/exam_information/157008.html']
questions = Array.new
bothLinks.each do |singleLink|
    page = Nokogiri::HTML(open(singleLink))
    puts page.class
    links = page.css('table.apc_table td.apText a')
    puts links
    hrefs = links.map {|link| link.attribute('href').to_s}
    puts hrefs
    hrefs.each do |url|
        if(url =~ /frq/)
            if(url !~ /http/)
                url = "http://apcentral.collegeboard.com" + url
            end
            questions.push(url)
            puts 'yes'
            puts url
        end
    end
end
puts questions

    questions.each do |filePath|
        
        io     = open(filePath)
        reader = PDF::Reader.new(io)
        
        solubility = false
        electrochemistry = false
        thermochemistry = false
        kinetics = false
        intermolecularForces = false

        pageNumber =1
        url = filePath
        basename = File.basename(url, ".pdf")
        begin
        Docsplit.extract_pages(filePath, output:'app/assets/pdf')

        reader.pages.each do |page|
            # puts page.fonts
            pagePath = basename + "_" + pageNumber.to_s + '.pdf'
            pageText = page.text
            if(pageText=~ /[1-9]./)
                text=""
                solubility = false
                electrochemistry = false
                thermochemistry = false
                kinetics = false
                intermolecularForces = false
            end
            
            text += pageText
            
            if(pageNumber>5)
            
                if(text =~ /equilibrium(.*)/)
                    puts "contains solubility"
                    solubility = true
                end
                if(text =~ /reduction potential(.*)/ )
                    puts electrochemistry
                    electrochemistry = true
                end
                if(text =~ /enthalpy(.*)/ )
                    puts thermochemistry
                    thermochemistry = true
                end 
                if(text =~ /rate(.*)/  )
                    puts kinetics
                    kinetics = true
                end
                if(text =~ /intermolecular(.*)/ || text =~ /Lewis(.*)/ )
                    puts intermolecularForces
                    intermolecularForces = true
                end
            
                Attachment.create(filePath:pagePath, solubility:solubility, electrochemistry:electrochemistry, thermochemistry:thermochemistry, kinetics:kinetics, intermolecularForces:intermolecularForces, subject:"chemistry")
            end
        pageNumber = pageNumber + 1
        puts solubility
        end
        rescue
            puts "java error-"+url
            IO.copy_stream(open(url), 'app/assets/pdf/downloaded.pdf')
            filePath = 'app/assets/pdf/' + basename + '.pdf'
            %x( gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="#{filePath}" app/assets/pdf/downloaded.pdf)
            reader = PDF::Reader.new(filePath)
            retry
        end

end


    

