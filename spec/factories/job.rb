
FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description  { Faker::Lorem.paragraph }
  end

  trait :activated do 
    after :create do |job, _evaluator|
      job.activate!
    end
  end

  trait :deactivated do 
    after :create do |job, _evaluator|
      job.deactivate!
    end
  end
end