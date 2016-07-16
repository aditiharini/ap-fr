module AttachmentsHelper
    def checkSubject(attachment, subject)
        bool = eval("#{attachment}.#{subject}")
        puts (bool)
        return bool
    end
end
