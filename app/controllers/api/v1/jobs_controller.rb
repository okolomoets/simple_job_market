class Api::V1::JobsController < ApplicationController
  
  def index
    render json: jobs, each_serializer: JobSerializer
  rescue NotSupportedStatusError => error
    render json: error, status: :unprocessable_entity
  end

  private

  ALLOWED_STATUSES = [:activated, :deactivated].freeze

  def jobs
    query = Job.includes(:events).includes(:applications)
    query = query.public_send(filter_params[:status]) if filter_params[:status]
    query
  end

  def filter_params
    params.permit(:status).tap do |params|
      return params if allowed_status?(params[:status])

      raise NotSupportedStatusError, 
        "Status #{params[:status]} is not supported. Supported statuses: #{ALLOWED_STATUSES}"
    end
  end

  def allowed_status?(status)
    status.nil? || ALLOWED_STATUSES.include?(status.to_sym)
  end
end
