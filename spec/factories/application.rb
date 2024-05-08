
FactoryBot.define do
  factory :application do
    job_id {}
    candidate_name { Faker::Name.name  }
  end

  trait :with_job do
    after :build do |application, _evaluator|
      application.job = create(:job)
    end
  end

  trait :hired do
    after :create do |application, _evaluator|
      application.hire!(Time.zone.now)
    end
  end

  trait :interviewed do 
    after :create do |application, _evaluator|
      application.interview!(Time.zone.now)
    end
  end

  trait :noted do 
    after :create do |application, _evaluator|
      application.note!(Faker::Lorem.paragraph)
    end
  end

  trait :rejected do 
    after :create do |application, _evaluator|
      application.reject!
    end
  end
end