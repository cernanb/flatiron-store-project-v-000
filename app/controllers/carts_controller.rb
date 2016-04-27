class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.status = "submitted"
    @cart.update_inventory
    current_user.remove_cart
    if @cart.save
      flash[:notice] = "Checkout successful"
      redirect_to cart_path(@cart)
    else
      flash[:notice] = "Unable to checkout"
      redirect_to cart_path(@cart)
    end
    # raise @cart.inspect

  end
end
