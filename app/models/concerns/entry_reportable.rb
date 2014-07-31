module EntryReportable extend ActiveSupport::Concern

  def reported?
    self.mail_sent
  end

  def report_title
    shops = wished_shops.map do |w|
      w.shop.name
    end
    "求人応募メール(No.#{id})" + shops.join(',')
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

    to = %w(saiyo@yamaokaya.com tanaka@yamaokaya.com sales-man@yamaokaya.com) 
    #PA応募の場合は店長SVを追加
    if pa?
      wished_shops.each do |w|
        to << w.shop.mail_addrs[:group]
        to << w.shop.mail_addrs[:sv]
      end
    end
    ses.send_email(
      to: to.uniq,
      source: 'recruit@yamaokaya.com',
      subject: report_title,
      html_body: render_mail(
        template: 'recruit/entries/mail',
        type: :haml,
        locals: {body: self},
        layout: false
      )
    )

    self.mail_sent = true
    self.save(validate: false)
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
