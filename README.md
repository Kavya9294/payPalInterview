# README

Overview of Design Decisions:
1) Input to the system is via the CLI by 
	1) passing a filename as an argument,
	2) passing a filename to STDIN
2) Read the file contents line by line and process each entry
3) Maintain a treeMap of all users so that it's alphabetically sorted
4) Each time an "Add" query is procesed, a user is added as a valid user if the card number is luhn 10 valid with a balance of $0, otherwise, the user is stored with value assigned as "error" 
5) Each time a "Charge" query is processed, first the system checks if the user is valid, and then checks if adding the "Charge" transaction does not increase the balance beyond the limit, otherwise, the transaction is declined
6) Each time a "Credit" query is processed, the system checks if the user is valid and then proceeds to subtract the credit amount from balance.
7) Since user data is stored in a treeMap, the keys are already sorted alphabetically and the system writes the summary to the console in the expected manner like having Name: $balance for valid cards and Name: error for invalid cards

Note: Using luhn gem to check for card validity. Using algorithms gem to store all users in treeMap.

Why choose Ruby on Rails:
Ruby on Rails spins up an entire MVC Framework that's able to extend the functionality of this system easily with the boilerplate code generated. It will also take less time to accomodate for more features as and when required.
Future requirements of incorporating a database with the system can be seamlessly achieved with rails models and migrations.

Installing required dependencies:
1) Download code base locally
2) Requires ruby 2.7.1 and Rails 7.0.4.

Note: If it doesn't work, try running bundle install in payPalBank directory

How to build, package or compile your code if applicable
NA

To run the code:
cd payPalBank
ruby ./app/runners/bank_script.rb input.txt 
or
ruby ./app/runners/bank_script.rb < input.txt
where input.txt has the input credit card transactions

To run tests:
bundle exec rspec ./spec/runners/bank_script_spec.rb
Expectation: all 8 test cases should pass




