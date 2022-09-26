module BankHelper
    def read
        if ARGV.length != 1
            puts "We need exactly one parameter. The name of a file."
            exit;
        end
    end
end
