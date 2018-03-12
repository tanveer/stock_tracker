class StocksController < ApplicationController

  def search
    if params[:stock].blank?
      flash.now[:danger] = "Please enter a valid stock symbol or company name"
    else
      @stock = Stock.lookup_stock_for(params[:stock])
      flash.now[:danger] = "Stock not found, or invalid stock symbol" unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end
