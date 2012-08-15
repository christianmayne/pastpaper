class Admin::OrdersController < ApplicationController
  def index
     @orders= Order.where("").order('id desc').paginate(:page => params[:page],  :per_page =>20)
  end

  def show
    @order= Order.find(params[:id])
  end

end
