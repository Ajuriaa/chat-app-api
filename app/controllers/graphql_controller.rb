class GraphqlController < ApplicationController

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
      login: method(:sign_in)
    }
    result = ChatAppApiSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  rescue => e
    if e.message == 'You are not logged in!'
      handle_authentication e
    elsif Rails.env.development?
      raise e
    else
      handle_error_in_development e
    end
  end

  private
  # Handle variables in form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {
      error: {
        message: e.message,
        backtrace: e.backtrace
      },
      data: {}
    }, status: 500
  end

  def handle_authentication(e)
    logger.error e.message

    render json: {
      error: {
        message: e.message
      },
      data: {}
    }, status: 401
  end
end
