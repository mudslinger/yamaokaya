module FeedbackReportable extend ActiveSupport::Concern
  def reported?
    self.mail_sent
  end

  def report_title
    sub = "お客様よりメール #{shop.name}(No.#{id})" if self.shop
    sub = "お客様よりメール (No.#{id})" unless self.shop
    sub += '【要返信】' if self.reply
    sub
  end

  def render_mail(var)
    action_view = ActionView::Base.new(Rails.configuration.paths["app/views"])
    action_view.class_eval do 
        include Rails.application.routes.url_helpers
        include ApplicationHelper
        def protect_against_forgery?
          false
        end
    end
    action_view.render var
  end
  def report
    ses_id = AWS_CREDENTIALS['access_key_id']
    ses_secret = AWS_CREDENTIALS['secret_access_key']
    ses = AWS::SES::Base.new(access_key_id: ses_id,secret_access_key: ses_secret)
    begin
      #生メール
      ses.send_email(
        to: 'info@yamaokaya.com',
        #to: 'tanaka@yamaokaya.com',
        source: 'kokyaku@yamaokaya.com',
        subject: report_title,
        html_body: render_mail(template: 'feedbacks/mail',type: :haml, locals: {body: self},layout: false)
      )
      #生メール（送信者個人情報無し）
      ses.send_email(
        to: 'customer_message@yamaokaya.co.jp',
        #to: 'hisato.tanaka@gmail.com',
        source: 'kokyaku@yamaokaya.com',
        subject: report_title + '(送信者個人情報削除済み)',
        html_body: render_mail({template: 'feedbacks/limited_mail',type: :haml, locals: {body: self},layout: false})
      )
      #マスクメール
      ses.send_email(
        to: 'sv@yamaokaya.com',
        #to: 'hisato.tanaka@gmail.com',
        source: 'kokyaku@yamaokaya.com',
        subject: report_title + '(個人情報削除済み)',
        html_body: render_mail({template: 'feedbacks/masked_mail',type: :haml, locals: {body: self},layout: false}),
        text_body: render_mail({template: 'feedbacks/masked_mail_txt',type: :erb, locals: {body: self},formats: :text, layout: false})
      )
    rescue
    ensure
      self.mail_sent = true
      self.save(validate: false)
    end
  end

  def message_i
    tagger = Igo::Tagger.new(Rails.root.join('lib','dic').to_s)
    tagger.parse(self.message).map{|m|
      m.feature.include?('固有') ? '●●●' : m.surface
    }.join if self.message.present?
  end

  def static_map
    # markers = []
    # #住所を正しく入力している場合
    # if self.address
    #   markers.push({
    #     location: self.address,
    #     color: "blue",
    #     label: "A"
    #   })
    # end

    # #店舗を選択している場合
    # if self.shop
    #   markers.push({
    #     latitude: self.shop.lat,
    #     longitude: self.shop.lng,
    #     color: "red",
    #     label: "Y"
    #   })
    # end

    # #緯度経度が特定される場合
    # if self.shop
    #   markers.push({
    #     latitude: self.lat,
    #     longitude: self.lng,
    #     color: "green",
    #     label: "C"
    #   })
    # end
    # StaticMap::Image.new(
    #   {
    #     size: '300x300',
    #     sensor: false,
    #     #center: "#{self.zip} #{self.address}",
    #     markers: markers,
    #     maptype: 'road',
    #     zoom: 11
    #   }
    # )
  end
end
