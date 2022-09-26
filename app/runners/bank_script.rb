require 'luhn'
require 'algorithms'

module BankScript
  extend self

  def formatLimitToInt(limit)
    # The following code removes "$" from the string
    # and converts it to integer
    limit[1..-1].to_i
  end

  def run(args)
    file = args.readlines
    if file.length == 0
      puts 'We need exactly one parameter. The name of a file.'
      exit
    end

    # Store all users
    all_users = Containers::RBTreeMap.new

    file.each do |line|
      items = line.split(' ')
      operation = items[0]
      case operation
      when 'Add'
        name = items[1]
        card = items[2]
        limit = formatLimitToInt(items[3])
        # Checking if card is valid
        if card.valid_luhn?
          # Adding new user with 0 balance
          all_users.push(name, { "card": card, "limit": limit, "balance": 0 })
        else
          # Adding invalid users
          all_users.push(name, { "value": 'error' })
        end
      when 'Charge'
        name = items[1]
        charge = formatLimitToInt(items[2])
        current_user = all_users[name]
        # Valid user
        if current_user.has_key?(:balance) && !((current_user[:balance] + charge) > current_user[:limit])
          # Don't charge unless balance within limits
          current_user[:balance] += charge
        end
      when 'Credit'
        name = items[1]
        credit = formatLimitToInt(items[2])
        current_user = all_users[name]
        # Check if user is valid before credit
        current_user[:balance] -= credit if current_user.has_key?(:balance)
      end
    end

    print_all_users(all_users)
  end

  # Formatting output as per requirement
  def print_all_users(all_users)
    all_users.each do |key, user|
      if user.has_key?(:balance)
        puts "#{key}: $#{user[:balance]}"
      else
        puts "#{key}: #{user[:value]}"
      end
    end
  end
end

BankScript.run(ARGF)
