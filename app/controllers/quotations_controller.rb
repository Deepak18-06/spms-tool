class QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotation, only: %i[ show edit update destroy ]

  # GET /quotations or /quotations.json
  def index
    @quotations = Quotation.all
    @quotations = @quotations.where(date: params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day) if params[:date].present?
    @quotations = @quotations.where(customer_id: params[:customer_id]) if params[:customer_id].present?
    @quotations = @quotations.joins(:customer).where("customers.first_name LIKE :name OR customers.last_name LIKE :name", name: "%#{params[:customer_name]}%") if params[:customer_name].present?
    @quotations = @quotations.where("attachment_filename LIKE ?", "%#{params[:attachment_filename]}%") if params[:attachment_filename].present?
  end

  # GET /quotations/1 or /quotations/1.json
  def show
  end

  # GET /quotations/new
  def new
    @quotation = Quotation.new
  end

  # GET /quotations/1/edit
  def edit
  end

  # POST /quotations or /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to quotation_url(@quotation), notice: "Quotation was successfully created." }
        format.json { render :show, status: :created, location: @quotation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1 or /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html { redirect_to quotation_url(@quotation), notice: "Quotation was successfully updated." }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1 or /quotations/1.json
  def destroy
    @quotation.destroy!

    respond_to do |format|
      format.html { redirect_to quotations_url, notice: "Quotation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quotation_params
      params.require(:quotation).permit(:attachment, :date, :comment, :customer_id)
    end
end
