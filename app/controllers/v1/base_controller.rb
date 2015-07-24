class V1::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def default_serializer_options
    { root: false }
  end
end
