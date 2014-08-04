class TopMessage
  include ActiveModel::Model


  def self.authenticate
    xml = RestClient.post(
      "https://login.microsoftonline.com/extSTS.srf",
      SPO_AUTHXML,
      content_type: "application/x-www-form-urlencoded",
      user_agent: 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0)'
    )
    doc = ActiveSupport::XmlMini.parse(xml)
    token = doc['Envelope']['Body']['RequestSecurityTokenResponse']['RequestedSecurityToken']['BinarySecurityToken']['__content__']

    puts token
    puts RestClient.get('https://yamaokaya1.sharepoint.com/')
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

end