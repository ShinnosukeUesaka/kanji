class Datedev < ApplicationRecord
    before_create :only_one
    
    
    class << self
      def getdate
        return Datedev.take.today
      end
    end
    
    
    private
    def only_one
        errors.add(:base, "You can create only one row of this table") if Datedev.count > 0
    end
end
