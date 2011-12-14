class PaymentsController < ApplicationController
 include ActiveMerchant::Billing::Integrations
  #protect_from_forgery :except => [:create, :paypal_return]

  # This action is for when the buyer returns to your site from PayPal
  def paypal_return
    flash[:notice] = "Thanks for buying this!"
    redirect_to root_path
   #return param format
   #   success?tx=3NP32002NG491474D&st=Completed&amt=40.00&cc=GBP&cm=72&item_number=72
  
  end
  

  # This action is for when the buyer cancels
  def paypal_cancel
    flash[:alert] = "We're sorry you didn't buy :("
    redirect_to root_path
  end

  # This is what will receive the IPN from PayPal
  def create
    # You maybe want to log this notification
   # mc_gross=40.00&protection_eligibility=Ineligible&payer_id=Q3WNA5PAFQV5S&tax=0.00&payment_date=01:40:40 Dec 14, 2011 PST&payment_status=Completed&charset=windows-1252&first_name=Test&mc_fee=1.56&notify_version=3.4&custom=72&payer_status=unverified&business=bibek_1316595699_biz@gmail.com&quantity=1&verify_sign=AijDJd.clPLUY5IvQoCC1yYaRnDgAgW..UCII0LMEhN6ZSggm8tsGbZY&payer_email=bibek._1316595823_per@gmail.com&txn_id=3NP32002NG491474D&payment_type=instant&last_name=User&receiver_email=bibek_1316595699_biz@gmail.com&payment_fee=&receiver_id=ZSLCY2KSA5S76&txn_type=web_accept&item_name=The prentice bible&mc_currency=GBP&item_number=72&residence_country=GB&test_ipn=1&handling_amount=0.00&transaction_subject=72&payment_gross=&shipping=0.00&ipn_track_id=oT2.J73qUePRMa7Zhi6ZGQ
    
    notify = Paypal::Notification.new request.raw_post
    @document= Document.find(params[:item_number])
   
    if @document
      
        @order = Order.find_by_paypal_txn_no(params[:txn_id])
        if @order
          #update 
        else
          #create
        @order=Order.new
        end
        
        @order.seller_id=@document.user_id
        @order.amount =@document.sale_price
        @order.buyer_email= params[:payer_email]
        @order.paypal_status= params[:payment_status]
        @order.item_number = params[:item_number]
        @order.document_name= @document.title
        @order.document_id= @document.id 
        @order.buyer_first_name = params[:first_name]
        @order.buyer_last_name = params[:last_name]
        @order.paypal_txn_no= params[:txn_id]
        @order.paypal_ipn_msg = params.to_s # all ipn msg by paypal is saved into this
        # need to update order table according to ipn msg    
          
        if notify.acknowledge
          @order.save
          # Make sure you received the expected payment!
        begin
          if notify.complete? and @order.price == BigDecimal.new( params[:mc_gross] )
            # All your bussiness logic goes here
            @order.update_attributes(:paid_status => true)
            @document_status= Status.find_by_name("Sold")
            #@docuemnt.update_attributes(:status_id => @document_status.id)
            @document.update_attributes(:status_id => 3)
            
            UserMailer.purchase_order_notification(@order).deliver
            render :nothing => true
         end
        rescue
        
        end
          #Make sure you log the exceptions you have.
       end
   end
  end
  
  
  
end
