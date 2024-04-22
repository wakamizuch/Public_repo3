class ErrorResponse
  LIST = Hash.new(500).merge({
    'ActiveModel::ForbiddenAttributesError'         => 400,
    'ActionController::BadRequest'                  => 400,
    'ActionController::ParameterMissing'            => 400,
    'ActionController::InvalidAuthenticityToken'    => 400,
    'ActionController::InvalidCrossOriginRequest'   => 400,
    'ActionController::RoutingError'                => 404,
    'ActiveRecord::RecordNotFound'                  => 404,
    'AbstractController::ActionNotFound'            => 404,
    'ActiveModel::ValidationError'                  => 422,
    'ActiveRecord::RecordInvalid'                   => 422,
    'ActiveRecord::RecordNotUnique'                 => 422,
  })

  def initialize(e)
    @error = e
  end

  def code
    LIST[@error.class.name]
  end

  def status
    Rack::Utils::HTTP_STATUS_CODES[code]
  end

  def status_sym
    status.split(' ').join.underscore.to_sym
  end

  def message
    @error.message
  end
end
