class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks


  def self.lookup_stock_for(symbol)
    begin
      stock = StockQuote::Stock.quote(symbol)
      price = remove_commas_from(stock.l)
      new(ticker: stock.symbol, name: stock.name, last_price: price)
    rescue Exception => e
      return nil
    end
  end

  def self.remove_commas_from(price)
    price.gsub(",", "")
  end

  def self.find_by_ticker(ticker)
    where(ticker: ticker).first
  end
end
