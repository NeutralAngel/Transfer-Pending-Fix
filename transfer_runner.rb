require_relative 'TransferPending'

module TransferPending
  class Runner
  
    require 'date'
  
    def run
      File.open('output.txt','w') do |file|
      end
      
      table = 'PMSC.BIL_DATES'
      currentDate = DateTime.now
      
      puts "Please enter the bill accound ID:" 
      accountID = gets.chomp.upcase

      puts "Please enter the start due date:"
      startDueDate = Date.strptime(gets.chomp,"%m/%d/%Y")
      
      puts "Please enter the reference date:"
      referenceDate = Date.strptime(gets.chomp,"%m/%d/%Y")
      
      puts "Do you need an update?"
      if gets.chomp.downcase == 'y'
        update = true
      end
      
      TransferPending::select(table, accountID, referenceDate, update)
      
      invoiceDate = TransferPending::weekend(startDueDate - 10)
      
      if update
        TransferPending::update(table, accountID, referenceDate, startDueDate, invoiceDate)
        startDueDate = TransferPending::increment(startDueDate)
        referenceDate = TransferPending::increment(referenceDate)
        invoiceDate = TransferPending::weekend(startDueDate - 10)
      end
      
      TransferPending::insert(table, accountID, referenceDate, startDueDate, invoiceDate)
      
      until invoiceDate > currentDate
          startDueDate = TransferPending::increment(startDueDate)
          referenceDate = TransferPending::increment(referenceDate)
          invoiceDate = TransferPending::weekend(startDueDate - 10)
          TransferPending::insert(table, accountID, referenceDate, startDueDate, invoiceDate)
      end
      
      TransferPending::select(table, accountID, referenceDate, false)
    end
  end
end
