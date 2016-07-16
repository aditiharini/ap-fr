module AttachmentsHelper
    def checkSubject(attachment, subject)
        bool = eval("attachment." + subject)
        return bool
    end
end
