class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  def index
    if params[:ids]
      @payments = Payment.where(:id => params[:ids]) 
    else
      @payments = Payment.all   
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    fetch_data
    @payment = Payment.new(:payment_date => Date.today)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  # Sample input PARAMS:
  # Parameters: {"utf8"=>"✓", "authenticity_token"=>"4xXEocM6Ls0fRD043RgXV9z/lndwp2g+6vzCpNfv2Qc=", "user_accounts"=>["9366937392"], 
  # "account_amts"=>{"9366937392"=>"900"}, "payment"=>{"amount"=>"900", "payment_date"=>"2014-01-05"}, "commit"=>"Pay", 
  # "vendor_accounts"=>["9328302332"], "vendor_amts"=>{"9328302332"=>"900"}}
  def create
    begin
      @payments = []
      Payment.transaction do
        user_accounts = params[:user_accounts] || [nil]
        vendor_acc = params[:vendor_accounts].first if params[:vendor_accounts] # Assuming only vendor gets the payment
        user_accounts.each do |acc|
          amt = params[:account_amts][acc] if params[:account_amts]
          @payment = Payment.new(params[:payment].merge(:acc_number => acc, :vendor_acc_number => vendor_acc, :amount => amt))
          @payment.save!
          Account.where(:number => acc).limit(1).first.add_balance(-@payment.amount)
          Vendor.where(:number => vendor_acc).limit(1).first.add_pending_amount(-@payment.amount)
          @payments << @payment
        end
      end
      redirect_to payments_url(:ids => @payments.map { |p| p.id }), notice: 'Payments successfully made.'
    rescue ActiveRecord::RecordInvalid => e
      # TODO: Log the error
      print e.inspect
      flash[:reqd_class] = 'danger'
      flash[:notice] = @payment.formatted_errors
      fetch_data
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  def fetch_data
    @vendors = Vendor.all
    @accounts = Account.all
  end
end
