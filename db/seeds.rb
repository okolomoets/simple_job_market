require 'factory_bot_rails'
require 'pry'

# This file provides the basic data to start your work on local environment

# The jobs list

activated_job = FactoryBot.create(:job, :activated)
deactivated_job = FactoryBot.create(:job, :deactivated)
empty_job = FactoryBot.create(:job)


# activated job with different apllications

applied_applications = FactoryBot.create_list(:application, 2, job_id: activated_job.id)

rejected_application_with_note = FactoryBot.create(
  :application, 
  :rejected, 
  :noted, 
  job_id: activated_job.id
)

rejected_application_after_interview = FactoryBot.create(
  :application, 
  :interviewed, 
  :rejected, 
  :noted, 
  job_id: activated_job.id
)

rejected_application = FactoryBot.create(
  :application, 
  :rejected, 
  :noted, 
  job_id: activated_job.id
)

rejected_without_note_application = FactoryBot.create(
  :application, 
  :rejected, 
  job_id: activated_job.id
)

hired_application_after_interview = FactoryBot.create(
  :application, 
  :interviewed, 
  :hired, 
  :noted, 
  job_id: activated_job.id
)


# deactivated job with different apllications

applied_applications = FactoryBot.create_list(:application, 4, job_id: deactivated_job.id)


rejected_application_after_interview = FactoryBot.create(
  :application, 
  :interviewed, 
  :rejected, 
  :noted, 
  job_id: deactivated_job.id
)

rejected_application = FactoryBot.create(
  :application, 
  :rejected, 
  :noted, 
  job_id: deactivated_job.id
)

hired_application = FactoryBot.create(
  :application, 
  :interviewed, 
  :hired, 
  :noted, 
  job_id: deactivated_job.id
)


hired_application2 = FactoryBot.create(
  :application, 
  :interviewed, 
  :hired,  
  job_id: deactivated_job.id
)

rejected_application2 = FactoryBot.create(
  :application, 
  :rejected, 
  :noted, 
  job_id: deactivated_job.id
)

rejected_without_note_application = FactoryBot.create(
  :application, 
  :rejected, 
  job_id: deactivated_job.id
)


# empty job with different apllications

applied_applications = FactoryBot.create_list(:application, 2, job_id: empty_job.id)

noted_application = FactoryBot.create(
  :application, 
  :noted, 
  job_id: empty_job.id
)

noted_application2 = FactoryBot.create(
  :application, 
  :noted, 
  job_id: empty_job.id
)