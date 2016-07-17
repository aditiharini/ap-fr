require 'pdf/reader'
require 'open-uri'
require 'docsplit'
require 'pdftk'
class AttachmentsController < ApplicationController
    helper AttachmentsHelper
    def index
        @subject = params[:subject]
        @attachments = []
        Attachment.where(subject:params[:subject]).find_each do |attachment|
            @attachments.push(attachment)
            # attachment.displayPath
        end
        # @subjects = {:chemistry => [""]}
    end
    
    def show
         @specAttachments = []
         @attachments.each do |file|
            #  if(@attachments.)
             
        end
    end
    
        
end
