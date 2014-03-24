class BatchPurchasesController < ApplicationController
  before_action :set_batch_purchase, only: :show
  before_action :new_batch_purchase, only: [:new, :create]

  # GET /batch_purchases/1
  # GET /batch_purchases/1.json
  def show
  end

  # GET /batch_purchases/new
  def new
  end

  # POST /batch_purchases
  # POST /batch_purchases.json
  def create
    if (params[:batch_purchase])
      first_line = true
      IO.foreach(params[:batch_purchase][:file].tempfile) do |purchase|
        @batch_purchase.parse_line(purchase) unless first_line
        first_line = false
      end
      if @batch_purchase.save
        redirect_to @batch_purchase, notice: 'Batch purchase was successfully created.'
      else
        render action: 'new'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch_purchase
      @batch_purchase = BatchPurchase.find(params[:id])
    end

    def new_batch_purchase
      @batch_purchase = BatchPurchase.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batch_purchase_params
      params[:batch_purchase]
    end
end
