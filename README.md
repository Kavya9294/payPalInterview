# README

Overview of Design Decisions:
1) Input to the system is via the CLI by 
	1) passing a filename as an argument,
	2) passing a filename to STDIN
2) Read the file contents line by line and process each entrty
3) Maintain 2 arrays, 1 for valid users and the other for invalid users
4) Each time an "Add" query is procesed, a user is added as a valid user if the card number is luhn 10 valid with a balance of 0, otherwise, the user is stored with an error value.
5) Each time a "Charge" query is processed, first the system checks if the user is valid, and then checks if by adding the charge transaction does not increase beyond the limit
6) Each time a "Credit" query is processed, the system checks if the user is valid and then proceeds to subtract the credit amount from balance.
7) Since user data is stored in a treeMap, the keys are already sorted and the system writes to the console in the expencted manner.

Chose Ruby on Rails:
Ruby on Rails spins up an entire system that's able to extend the functionality of this system easily. It will also take less time to extend this system to accomodate for more features.
The future thought of this system is to incorporate the current system with a database which is available out of the box with ruby on rails.

Installing required dependencies:
1) Download code base locally
2) Requires ruby 2.7.1 and Rails 7.0.4.
3) After updating ruby and rails, run bundle install

How to build, package or compile your code if applicable
NA

To run the code:
cd payPalBank
ruby ./app/runners/bank_script.rb input.txt || ruby ./app/runners/bank_script.rb < input.txt
where input.txt has the input credit card transactions details

To run tests:
bundle exec rspec ./spec/runners/bank_script_spec.r





