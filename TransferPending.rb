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
      
      def insert (table, accountID, referenceDate, sysDueDate, invDate)
        File.open('output.txt','a') do |file|
          file.puts "INSERT INTO #{table}"
          file.puts "VALUES ('#{accountID}'"
          file.puts "       ,'#{referenceDate.strftime('%m/%d/%Y')}'"
          file.puts "       ,'#{sysDueDate.strftime('%m/%d/%Y')}'"
          file.puts "       ,'#{sysDueDate.strftime('%m/%d/%Y')}'"
          file.puts "       ,'#{invDate.strftime('%m/%d/%Y')}'"
          file.puts "       ,'S'"
          file.puts "       ,'N'"
          file.puts "       ,' '"
          file.puts "       ,'Y'"
          file.puts "       ,'N'"
          file.puts "       ,' ')"
          file.puts ";"
        end
      end
      
      def update (table, accountID, referenceDate, adjDueDate, invDate)
        File.open('output.txt', 'a') do |file|
          file.puts "UPDATE"
          file.puts "     #{table}"
          file.puts "SET   BIL_ADJ_DUE_DT   = '#{adjDueDate.strftime('%m/%d/%Y')}'"
          file.puts ",     BIL_INV_DT       = '#{invDate.strftime('%m/%d/%Y')}'"     
          file.puts "WHERE BIL_ACCOUNT_ID   = '#{accountID}'"
          file.puts "AND   BIL_REFERENCE_DT = '#{referenceDate.strftime('%m/%d/%Y')}'"
          file.puts ";" 
        end
      end
      
      def select (table, accountID, referenceDate, update)
        File.open('output.txt', 'a') do |file|
          file.puts "SELECT *"
          file.puts "FROM #{table}"
          file.puts "WHERE BIL_ACCOUNT_ID   = '#{accountID}'"
          file.puts "AND   BIL_REFERENCE_DT = '#{referenceDate.strftime('%m/%d/%Y')}'" if update
          file.puts ";" 
        end
      end
      
      def increment (date)
        month = date.month
        month += 1
        return Date.new(date.year, month, date.day)
      end
    end
  end
end