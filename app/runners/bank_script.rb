require "luhn"

module BankScript
  extend self
  
  def formatLimitToInt(limit)
    #The following code removes "$" from the string 
    #and converts it to integer
    return limit[1..-1].to_i
  end

	def run(args)
		if args.length != 1
			puts "We need exactly one parameter. The name of a file."
			exit;
		end
    
		filename = args[0]
		fh = open filename
    #Store all valid users
		valid_users = {}
    #Store all invalid users
		invalid_users = {}
		while (line = fh.gets) 
			items = line.split(" ")
			operation = items[0]
			case operation
				when "Add"
					name = items[1]
					card = items[2]
					limit = formatLimitToInt(items[3])
				  if card.valid_luhn?
						valid_users[name] = {"card": card, "limit": limit, "balance": 0}
				  else
						invalid_users[name] = {"value": "Error"}
				  end
		    when "Charge"
				  name = items[1]
				  charge = formatLimitToInt(items[2])
				  current_user = valid_users[name]
				  #Valid user
				  unless current_user.nil?
						#balance < limit
						unless (current_user[:balance] + charge) > current_user[:limit]
							current_user[:balance] += charge
						end
				  end
		    when "Credit"
				  name = items[1]
				  credit = formatLimitToInt(items[2])
				  current_user = valid_users[name]
				  #Check if user is valid before credit
				  unless current_user.nil?
						current_user[:balance] -= credit
				  end          
			end
	  end
    fh.close
    print_all_users(valid_users, invalid_users)
    
    # self.exit
	end

  #Formatting outputt as per requirement
  def print_all_users(valid_users, invalid_users)
    valid_users.each do |key, value|
		  puts "#{key}: $#{value[:balance]}"
	  end
	  invalid_users.each do |key, value|
			puts "#{key}: #{value[:value]}"  
	  end
  end

end
			

BankScript.run(ARGV)