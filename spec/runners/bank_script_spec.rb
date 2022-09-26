require_relative '../../app/runners/bank_script.rb'

describe BankScript do
    let(:Tom){:name => "Tom", "card": "4111111111111111", "limit": 1000, "balance": 0 }
    # let(:tom){'Awesome tests'}
    describe ".run" do
        it "creates Tom" do
            expect{ described_class.run(tom) }
            .to output("Awesome tests\n").to_stdout
        end
    end
end