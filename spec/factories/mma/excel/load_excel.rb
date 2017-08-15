FactoryGirl.define do
  factory :load_excel, class: MMA::Excel::LoadExcel do |factory|
    initialize_with{ MMA::Excel::LoadExcel.new( nil ) }
  end
end
