class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all 
    @payments = Payment.where(:id => params[:ids]) if params[:ids]
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
    @vendors = Vendor.all
    @accounts = Account.all
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
  def create
    @payments = []
    Payment.transaction do
      vendor_acc = params[:vendor].keys.first # Assuming only vendor gets the payment
      params[:account].each do |acc, amt|
        amt = Integer(amt)
        @payments << Payment.create!(:acc_number => acc, :vendor_acc_number => vendor_acc, :amount => amt, 
            :payment_date => params[:payment][:payment_date])
        Account.where(:number => acc).limit(1).first.add_balance(-amt)
        Vendor.where(:number => vendor_acc).limit(1).first.add_pending_amount(-amt)
      end
      redirect_to payments_url(:ids => @payments.map { |p| p.id }), notice: 'Payments successfully made.'
    end

    # respond_to do |format|
    #   if @payment.save
    #     format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
    #     format.json { render json: @payment, status: :created, location: @payment }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @payment.errors, status: :unprocessable_entity }
    #   end
    # end
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
end
