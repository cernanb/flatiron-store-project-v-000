class LineItemsController < ApplicationController
  def create
    current_user.set_current_cart unless current_user.current_cart
    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      flash[:notice] = "Item added to cart"
      redirect_to cart_path(current_user.current_cart)
    else
      flash[:error] = "Unable to add item to cart"
      redirect_to store_path
    end
  end


end
