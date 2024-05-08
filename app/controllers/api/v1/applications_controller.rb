class Api::V1::ApplicationsController < ApplicationController
  
  def index
    render json: applications, each_serializer: ApplicationSerializer
  rescue NotSupportedStatusError => error
    render json: error, status: :unprocessable_entity
  end

  private

  ALLOWED_STATUSES = [:activated, :deactivated].freeze

  def applications
    Application.
      joins(:job).includes(:job, :events).
      merge(Job.public_send(status))
  end

  def filter_params
    params.permit(:status).tap do |params|
      return params if allowed_status?(params[:status])

      raise NotSupportedStatusError, 
        "Status #{params[:status]} is not supported. Supported statuses: #{ALLOWED_STATUSES}"
    end
  end

  def status
    return :activated unless filter_params[:status]

    filter_params[:status]
  end

  def allowed_status?(status)
    status.nil? || ALLOWED_STATUSES.include?(status.to_sym)
  end
end
