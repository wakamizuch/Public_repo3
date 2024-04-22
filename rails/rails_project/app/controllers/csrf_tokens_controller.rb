class CsrfTokensController < ApplicationController
  def show
    response.set_header('X-CSRF-Token', form_authenticity_token)
    render_success
  end
end
