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
bothLinks = ['http://apcentral.collegeboard.com/apc/members/exam/exam_information/2002.html','http://apcentral.collegeboard.com/apc/members/exam/exam_information/157131.html']
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
        url = filePath
        basename = File.basename(url, ".pdf")
        fromUrl = true
        begin
        if fromUrl
            io     = open(filePath)
            reader = PDF::Reader.new(io)
        end
        
        q1 = false
        q2 = false
        q3 = false

        pageNumber =1
        
        

        # begin
        Docsplit.extract_pages(filePath, output:'app/assets/lit')
        puts "got to docsplit"

        reader.pages.each do |page|
            puts "got to page reading"
            # puts page.fonts
            pagePath = basename + "_" + pageNumber.to_s + '.pdf'
            pageText = page.text
            # puts pageText

            if(pageNumber>1)
                puts "got into if statement"
            
                if(pageText =~ /Question 1(.*)/)
                    q1 = true
                    q2 = false
                    q3 = false
                
                elsif(pageText =~ /Question 2(.*)/ )
                    q2 = true
                    q1 = false
                    q3 = false
                   
                elsif(pageText =~ /Question 3(.*)/ )
                    q3 = true
                    q1= false
                    q2 = false
                    
                end 
                puts "created db entry"
            
                Attachment.create(filePath:pagePath, question1:q1, question2:q2, question3:q3, subject:"lit")
            end
            pageNumber = pageNumber + 1
        
        end
        rescue
            puts "java error-" + url
            IO.copy_stream(open(url), 'app/assets/lit/downloaded.pdf')
            filePath = 'app/assets/lit/' + basename + '.pdf'
            %x( gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="#{filePath}" app/assets/lit/downloaded.pdf)
            reader = PDF::Reader.new(filePath)
            fromUrl = false
            retry
        end
    
        # rescue
        #     puts "encryption error"
        #     next
        # end
end

    


    

