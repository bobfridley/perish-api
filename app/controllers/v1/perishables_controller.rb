class V1::PerishablesController < V1::BaseController
  def show
    @perishable = Perishable.find_by digest: params[:id]

    if @perishable.nil?
      render json: { error: 'not found' }, status: :not_found
      return
    end

    @document = @perishable.get_document show_params
    if @document
      send_data @document.read, type: @perishable.document.content_type
      @perishable.destroy
    else
      render json: { error: 'not found' }, status: :not_found
    end
  end

  def create
    @perishable = Perishable.new perishable_params
    if @perishable.save
      render json: @perishable, include_crypto: true, status: :created
    else
      render json: @perishable.errors, status: :unprocessable_entity
    end
  end

  private

  def perishable_params
    params.permit(:document)
  end

  def show_params
    params.permit(:key, :iv)
  end
end
