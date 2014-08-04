class TopMessagesController < ApplicationController
  include TopMessagesHelper
  skip_before_filter :set_title
  layout false

  def authentication
    ActiveSupport::XmlMini.backend = 'Nokogiri'
    xml = RestClient.post(
      "https://login.microsoftonline.com/extSTS.srf",
      SPO_AUTHXML,
      content_type: "application/x-www-form-urlencoded",
      user_agent: 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0)'
    )
    doc = ActiveSupport::XmlMini.parse(xml)
    token = doc['Envelope']['Body']['RequestSecurityTokenResponse']['RequestedSecurityToken']['BinarySecurityToken']['__content__']

    puts token
    puts RestClient.get("https://yamaokaya1.sharepoint.com/")
    #tokenをキーにしてクッキーをゲット
    RestClient.post(
      "https://yamaokaya1.sharepoint.com/_forms/default.aspx?wa=wsignin1.0",
      token,
      {
        :content_type => "application/x-www-form-urlencoded",
        :user_agent => 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0)'
      }
    ){ |response, request, result|
      if [301, 302, 307].include? response.code
        str = ""
        response.headers[:set_cookie].each do |s|
          str << s << "; " if s =~ /^FedAuth/
          str << s << "; " if s =~ /^rtFa/
        end
        puts str
      end
    }
  end

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
