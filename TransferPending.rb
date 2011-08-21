module TransferPending
  class TransferPending
    
    require 'date'

    class << self
    
      def weekend(date)
        if date.wday == 0
          return date + 1
        elsif date.wday == 6
          return date - 1
        else
          return date
        end
      end
      
      def insert (billDates)
        File.open('output.txt','a') do |file|
          file.puts "INSERT INTO #{billDates[:table]}"
          file.puts "VALUES ('#{billDates[:accountID]}'"
          file.puts "       ,'#{billDates[:referenceDate].strftime('%m/%d/%Y')}'"
          file.puts "       ,'#{billDates[:startDueDate].strftime('%m/%d/%Y')}'"
          file.puts "       ,'#{billDates[:startDueDate].strftime('%m/%d/%Y')}'"
          file.puts "       ,'#{billDates[:invoiceDate].strftime('%m/%d/%Y')}'"
          file.puts "       ,'S'"
          file.puts "       ,'N'"
          file.puts "       ,' '"
          file.puts "       ,'Y'"
          file.puts "       ,'N'"
          file.puts "       ,' ')"
          file.puts ";"
        end
      end
      
      def update (billDates)
        File.open('output.txt', 'a') do |file|
          file.puts "UPDATE"
          file.puts "     #{billDates[:table]}"
          file.puts "SET   BIL_ADJ_DUE_DT   = '#{billDates[:startDueDate].strftime('%m/%d/%Y')}'"
          file.puts ",     BIL_INV_DT       = '#{billDates[:invoiceDate].strftime('%m/%d/%Y')}'"     
          file.puts "WHERE BIL_ACCOUNT_ID   = '#{billDates[:accountID]}'"
          file.puts "AND   BIL_REFERENCE_DT = '#{billDates[:referenceDate].strftime('%m/%d/%Y')}'"
          file.puts ";" 
        end
      end
      
      def select (billDates)
        File.open('output.txt', 'a') do |file|
          file.puts "SELECT *"
          file.puts "FROM #{billDates[:table]}"
          file.puts "WHERE BIL_ACCOUNT_ID   = '#{billDates[:accountID]}'"
          file.puts "AND   BIL_REFERENCE_DT = '#{billDates[:referenceDate].strftime('%m/%d/%Y')}'" if billDates[:update]
          file.puts ";" 
        end
      end
      
      def increment (date)
        date>>(1)
      end
    end
  end
end