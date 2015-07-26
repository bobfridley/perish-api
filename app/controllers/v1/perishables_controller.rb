class V1::PerishablesController < V1::BaseController

  def show
    @perishable = Perishable.find_by digest: params[:id]

    if @perishable
      render json: @perishable, status: :ok
    else
      render json: { error: 'not found' }, status: :not_found
    end
  end

  def create
    @perishable = Perishable.new perishable_params

    if @perishable.errors.any? || !@perishable.save
      render json: @perishable.errors, status: :unprocessable_entity
    else
      render json: @perishable, include_crypto: true, status: :created
    end
  end

  private

  def perishable_params
    params.permit(:document)
  end

end
