FactoryGirl.define do
  factory :loan, class: MMA::Loan do |factory|
    initialize_with{ MMA::Loan.new( nil ) }
  end
end
