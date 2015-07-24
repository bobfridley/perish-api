class V1::PerishablesController < V1::BaseController
  def show
    @perishable = Perishable.find_by digest: params[:id]

    if @perishable
      File.open(@perishable.document.path, 'r') do |f|
        send_data f.read, type: @perishable.document.content_type
      end
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
end
