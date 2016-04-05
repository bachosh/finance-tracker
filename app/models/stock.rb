class Stock < ActiveRecord::Base
  
    has_many :user_stocks
    has_many :users, through: :user_stocks
    
    def self.find_by_ticker(ticker_symbol)   # bazashi edzebs stoks cxrilshi
      where(ticker: ticker_symbol).first
    end
# We are adding the self. prior to the method name, 
# because these methods are not tied to any objects or object lifecycle,
# we need to be able to use them without having any instances of a stock.    
    
    
    
    def self.new_from_lookup(ticker_symbol)
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)  # gem files is dzebnis metodia, abrunebs hashs
      
      return nil unless looked_up_stock.name
      new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)  # ketdeba new_stock hash i
      new_stock.last_price = new_stock.price  #emateba wyvili ?
      new_stock
    end
    
    
    def price
      closing_price = StockQuote::Stock.quote(ticker).close
      return "#{closing_price} (Closing)" if closing_price
      opening_price = StockQuote::Stock.quote(ticker).open
      return "#{opening_price} (Opening)" if opening_price
      'Unavailable'
    end
  
  
  
end
