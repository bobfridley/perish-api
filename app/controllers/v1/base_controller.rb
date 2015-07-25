class V1::BaseController < ApplicationController

  def default_serializer_options
    { root: false }
  end

end
