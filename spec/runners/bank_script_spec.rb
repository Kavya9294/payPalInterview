require_relative '../../app/runners/bank_script'
require 'luhn'
require 'algorithms'

describe BankScript do
  let(:file_like_object) { double('Add Tom 4111111111111111 $1000') }

  let(:content_create) { StringIO.new('Add Tom 4111111111111111 $1000') }
  let(:content_charge) { StringIO.new("Add Tom 4111111111111111 $1000\nCharge Tom $500\nCharge Tom $200") }
  let(:content_credit) { StringIO.new("Add Tom 4111111111111111 $1000\nCredit Tom $100") }
  let(:content_error) { StringIO.new('Add Tom 1234567890123456 $1000') }
  let(:content_update) { StringIO.new("Add Tom 4111111111111111 $1000\nCharge Tom $7\nCredit Tom $100") }
  let(:content_charge_limit) { StringIO.new("Add Tom 4111111111111111 $1000\nCharge Tom $500\nCharge Tom $800") }
  let(:content_error_update) { StringIO.new("Add Tom 1234567890123456 $1000\nCharge Tom $100\nCredit Tom $200") }
  let(:content_create_users) { StringIO.new("Add Tom 4111111111111111 $1000\nAdd Lisa 5454545454545454 $3000") }
  let(:content_create_highest) { StringIO.new('Add Tom 8862333771793384016 $1000') }

  describe 'run' do
    @filename = 'file.txt'
    args =  []
    args[0] = @filename

    # Testing creation of new user
    it 'creates new User with 0 balance' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_create)
      expect { described_class.run(args) }
        .to output("Tom: $0\n").to_stdout
    end

    # Testing basic charge operation
    it 'creates User with charged balance' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_charge)
      expect { described_class.run(args) }
        .to output("Tom: $700\n").to_stdout
    end

    # Testing basic credit operation
    it 'creates User with credited balance' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_credit)
      expect { described_class.run(args) }
        .to output("Tom: $-100\n").to_stdout
    end

    # Testing luhn 10 invalid card scenario
    it 'leads to error due to inavlid card' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_error)
      expect { described_class.run(args) }
        .to output("Tom: error\n").to_stdout
    end

    # Testing Add, Charge and credit oprations
    it 'Creates user, charges balance and credits balance' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_update)
      expect { described_class.run(args) }
        .to output("Tom: $-93\n").to_stdout
    end

    # Testing Charge above limit scenario
    it 'creates User and keeps balance within limits by invalidating query' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_charge_limit)
      expect { described_class.run(args) }
        .to output("Tom: $500\n").to_stdout
    end

    # Testing multiple operations on invalid user
    it 'leads to error due to inavlid card and balance is not updated' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_error_update)
      expect { described_class.run(args) }
        .to output("Tom: error\n").to_stdout
    end

    # Testing multiple user creation in alphabetical order
    it 'creates new User with 0 balance' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_create_users)
      expect { described_class.run(args) }
        .to output("Lisa: $0\nTom: $0\n").to_stdout
    end

    # Testing user with maximum valid credit card number length
    it 'creates new User with 0 balance with 19 digit card number' do
      allow_any_instance_of(Object).to receive(:readlines).and_return(content_create_highest)
      expect { described_class.run(args) }
        .to output("Tom: $0\n").to_stdout
    end
  end
end
