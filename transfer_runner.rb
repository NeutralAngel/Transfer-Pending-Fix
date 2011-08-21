require_relative 'TransferPending'

module TransferPending
  class Runner
  
    require 'date'
  
    def run
      File.open('output.txt','w') do |file|
      end
      
      billDates = {:table => 'PMSC.BIL_DATES'}
      currentDate = DateTime.now
      
      puts "Please enter the bill accound ID:" 
      billDates[:accountID] = gets.chomp.upcase

      puts "Please enter the start due date:"
      billDates[:startDueDate] = Date.strptime(gets.chomp,"%m/%d/%Y")
      
      puts "Please enter the reference date:"
      billDates[:referenceDate] = Date.strptime(gets.chomp,"%m/%d/%Y")
      
      puts "Do you need an update?"
      if gets.chomp.downcase == 'y'
        billDates[:update] = true
      end
      
      billDates[:invoiceDate] = TransferPending::weekend(billDates[:startDueDate] - 10)
      
      TransferPending::select(billDates)
                  
      if billDates[:update]
        TransferPending::update(billDates)
        billDates[:startDueDate] = TransferPending::increment(billDates[:startDueDate])
        billDates[:referenceDate] = TransferPending::increment(billDates[:referenceDate])
        billDates[:invoiceDate] = TransferPending::weekend(billDates[:startDueDate] - 10)
      end
      
      TransferPending::insert(billDates)
      
      until billDates[:invoiceDate] > currentDate
          billDates[:startDueDate] = TransferPending::increment(billDates[:startDueDate])
          billDates[:referenceDate] = TransferPending::increment(billDates[:referenceDate])
          billDates[:invoiceDate] = TransferPending::weekend(billDates[:startDueDate] - 10)
          TransferPending::insert(billDates)
      end
      
      billDates[:update] = false
      TransferPending::select(billDates)
    end
  end
end
