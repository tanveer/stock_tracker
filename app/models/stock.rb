class Stock < ApplicationRecord

  def self.lookup_stock_for(symbol)
    begin
      stock = StockQuote::Stock.quote(symbol)
      price = remove_commas_from(stock.l)
      new(ticker: stock.symbol, name: stock.name, last_price: price)
    rescue Exception => e
      return nil
    end 
  end

  private
    def self.remove_commas_from(price)
      price.gsub(",", "")
    end
end
