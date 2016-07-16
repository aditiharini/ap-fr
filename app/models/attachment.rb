class Attachment < ActiveRecord::Base
    def setPath(path)
        self.filePath = path
    end
    
    def setSolubility(sol)
        self.solubility = sol
    end
    def displayPath
        puts self.filePath
    end
end
