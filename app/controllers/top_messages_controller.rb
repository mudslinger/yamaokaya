class TopMessagesController < ApplicationController
  skip_before_filter :set_title
  layout 'top_messages'
  
  def show
      @type = params[:type] if present?
      @key = 0
      @key = params[:key].to_i if present?

      list = nil
      cache_key = [@type,@key].join('#')
      begin
        list = Redis.current.lrange(@type,(@key == 0 ? 0 : @key-1),@key+1).map{ |item|
          OpenStruct.new(MessagePack.unpack(item)).extend(Message)
        }
        Rails.cache.write(cache_key,list,:expires_in => 10.minutes) unless Rails.cache.read(cache_key)
      rescue
        list = Rails.cache.read(cache_key)
      ensure
        @entry = @key == 0 ? list[0] : list[1]
        @prev_entry = @key == 0 ? nil : list[0]
        @next_entry = @key == 0 ? list[1] : list[2]
      end
  end
end
