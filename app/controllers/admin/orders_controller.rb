class Admin::OrdersController < ApplicationController
  def index
     @orders=Order.all.paginate(:page =>params[:page], :order =>'id desc', :per_page =>20)
  end

  def show
    @order= Order.find(params[:id])
  end

end
