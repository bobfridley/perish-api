class V1::DownloadsController < V1::BaseController

  def create
    @perishable = Perishable.find_by digest: params[:perishable_id]

    if @perishable.nil?
      render json: { error: 'not found' }, status: :not_found
      return
    end

    @document = @perishable.get_document download_params
    if @document
      send_data @document.read, type: @perishable.document.content_type
      @perishable.destroy
    else
      render json: { error: 'not found' }, status: :not_found
    end
  end

  private

  def download_params
    params.permit(:key, :iv)
  end

end
