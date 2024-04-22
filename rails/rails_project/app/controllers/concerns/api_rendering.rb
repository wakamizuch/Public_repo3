module ApiRendering
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :render_error
  end

  private
  def render_json(params, **options)
    render(json: { **params, **options }, **options)
  end

  def render_error(e)
    logger.error(e)
    e.backtrace.each { |line| logger.error line }
    error = ErrorResponse.new(e)
    params = { message: error.message }
    options = { status: error.status_sym, code: error.code }
    render_json(params, **options)
  end

  def render_success(params={})
    render_json(params, status: :ok, code: 200)
  end
end
