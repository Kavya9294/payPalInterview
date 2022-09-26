if ARGV.length != 1
    puts "We need exactly one parameter. The name of a file."
    exit;
end
 
filename = ARGV[0]
 
fh = open filename

valid_users = {}
invalid_users = {}
i = 0
j = 0
while (line = fh.gets) 
    items = line.split(" ")
    operation = items[0]
    case operation
        when "Add"
            name = items[1]
            card = items[2]
            limit = items[3][1..-1].to_i
            if card.valid_luhn?
                valid_users[name] = {"name": name, "card": card, "limit": limit, "balance": 0}
            else
                invalid_users[name] = {"name": name, "value": "Error"}
            end
        when "Charge"
            name = items[1]
            charge = items[2][1..-1].to_i
            current_user = valid_users[name]
            unless current_user.nil?
                unless (current_user[:balance] + charge) > current_user[:limit]
                    current_user[:balance] += charge
                end
            end
        when "Credit"
            name = items[1]
            credit = items[2][1..-1].to_i
            current_user = valid_users[name]
            unless current_user.nil?
                current_user[:balance] -= credit
            end            
    end
end

valid_users.each do |key, value|
    puts "#{key}: $#{value[:balance]}"
end

invalid_users.each do |key, value|
    puts "#{key}: #{value[:value]}"  
end
        


 
fh.close