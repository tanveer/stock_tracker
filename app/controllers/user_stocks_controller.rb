class UserStocksController < ApplicationController

  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.blank?
      stock = Stock.lookup_stock_for(params[:stock_ticker])
      stock.save
    else
      @user_stock = UserStock.create(user: current_user, stock: stock)
      flash[:success] = "#{@user_stock.stock.name} added to your portfolio"
      redirect_to my_portfolio_path
    end
  end

  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy
    flash[:alert] = "You have removed #{@user_stock.stock.name} from your list."
    redirect_to my_portfolio_path
  end
end
