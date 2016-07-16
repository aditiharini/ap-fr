require 'rubygems'
require 'open-uri'
require 'docsplit'
require 'pdftk'

IO.copy_stream(open(url), 'app/assets/pdf/downloaded.pdf')
filePath = 'app/assets/pdf/' + basename + '.pdf'
%x( gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="#{filePath}" app/assets/pdf/downloaded.pdf)


    