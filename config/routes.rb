Rails.application.routes.draw do

  #yamaokaya.comドメインだった場合
  constraints host: 'yamaokaya.com' do
    root :to => redirect('https://www.yamaokaya.com/'),via: [:get,:post]
  end

  #社内用トップメッセージ
  constraints host: 'winbordmessages.yamaokaya.com' do
    get '/wb/:type/:key(.:format)' => 'top_messages#show',as: :top_messages
  end

  get '/ir/announce/index(.:format)' => redirect("https://maruchiyo.yamaokaya.com/ir/market"),as: :announce_redirect

  #common
  get '/about' => 'articles#about',as: :about
  get '/sns_guideline' => 'articles#sns_guideline',as: :sns_guideline
  get '/sitemap' => 'articles#sitemap',as: :sitemap
  get '/mag_faq' => 'articles#mag_faq', as: :mag_faq
  get '/service_tickets' => 'articles#service_tickets', as: :service_tickets
  get '/privacy_policy' => 'articles#privacy_policy', as: :privacy_policy
  get '/google_map/:address' => redirect("https://maps.google.co.jp/maps?q=%{address}"),as: :google_map

  #リリース一覧表示用
  get '/releases' => 'releases#releases',as: :releases
  #リリース単発表示用
  get '/releases/:id' => 'releases#release',as: :release

  #地図用json
  get '/markers' => 'brand_yamaokaya/shops#markers', as: :markers

  #近隣検索用json
  get '/nerby_shops' => 'brand_yamaokaya/shops#nerby_shops',as: :nerby_shops

  constraints size: /[0-9]{0,4}x[0-9]{0,4}|origin/,file: /.*/ do
    get '/i/:size/:file' => 'images#show' , as: :img
  end

  get '/feedbacks' => 'feedbacks#new',as: :feedbacks
  post '/feedbacks' => 'feedbacks#create',as: :feedbacks_post
  get '/feedbacks/:id(.:format)' => 'feedbacks#api',as: :feedbacks_api

  constraints lambda {|request| CORPORATE_DOMAINZ.include? request.host} do
    scope module: :corporate do
      get '/' => 'top#index',as: :corp_top,host: CORP_DEF
      get '/index(.:format)' => 'top#index',as: :corp_top_variant,host: CORP_DEF
      get '/greetings' => 'top#greetings',as: :greetings,host: CORP_DEF
      get '/company/history' => 'company#history',as: :history,host: CORP_DEF
      get '/company/overview' => 'company#overview',as: :overview,host: CORP_DEF
      get '/business/yamaokaya' => 'business#yamaokaya',as: :business,host: CORP_DEF
      get '/business/yamaokaya/products' => 'business#products',as: :products,host: CORP_DEF
      get '/business/yamaokaya/hospitality' => 'business#hospitality',as: :hospitality,host: CORP_DEF
      get '/business/yamaokaya/safety' => 'business#safety',as: :safety,host: CORP_DEF
      get '/business/yamaokaya/development' => 'business#development',as: :development,host: CORP_DEF
      # get '/business/yamaokaya/ict' => 'business#ict',as: :ict,host: CORP_DEF
      get '/ir' => 'ir#index',as: :ir_top,host: CORP_DEF
      get '/ir/market' => 'ir#market',as: :market,host: CORP_DEF
      get '/ir/highlight' => 'ir#highlight',as: :highlight,host: CORP_DEF
      get '/ir/library' => 'ir#library',as: :library,host: CORP_DEF
      # get '/ir/infomation' => 'ir#infomation',as: :infomation
      get '/ir/calender' => 'ir#calender',as: :calender,host: CORP_DEF
      get '/ir/disclaimer' => 'ir#disclaimer',as: :disclaimer,host: CORP_DEF
      get '/ir/financial_infomation' => 'ir#financial_info',as: :financial_info,host: CORP_DEF
      get '/ir/incentives' => 'ir#incentives',as: :incentives,host: CORP_DEF
      get '/property' => 'property#development',as: :property,host: CORP_DEF
    end
  end

  constraints lambda {|request| YAMAOKAYA_DOMAINZ.include? request.host} do
    scope module: :brand_yamaokaya do
      get '/' => 'top#index',as: :yamaokaya_top,host: YAM_DEF
      get '/index(.:format)' => 'top#index',as: :yamaokaya_top_variant,host: YAM_DEF
      get '/shops/:key' => 'shops#details', as: :shop_details,host: YAM_DEF
      get 'shops' => 'shops#shops', as: :shop_root,host: YAM_DEF
      get 'big_map' => 'shops#big_map',host: YAM_DEF

      get '/my_business_locations(.:format)' => 'shops#my_business_locations',host: YAM_DEF
      constraints id: /[0-9]+/ do
        get 'menus/:id' => 'menus#details',as: :menu_details,host: YAM_DEF
      end
      get 'menus/:category' => 'menus#categorized', as: :menu_categorized ,host: YAM_DEF
    end
  end

  constraints lambda {|request| RECRUIT_DOMAINZ.include? request.host} do
    scope module: :recruit do
      get '/' => 'top#index',as: :recruit_top,host: REC_DEF
      get '/index(.:format)' => 'top#index',as: :recruit_top_variant,host: REC_DEF

      #message
      get '/graduates/message' => 'message#graduates',as: :message_graduates,host: REC_DEF
      get '/career/message' => 'message#career',as: :message_career,host: REC_DEF
      get '/pa/message' => 'message#pa',as: :message_pa,host: REC_DEF
      #interview
      get '/graduates/interview' => 'interview#graduates',as: :interview_graduates,host: REC_DEF
      get '/career/interview' => 'interview#career',as: :interview_career,host: REC_DEF
      get '/pa/interview' => 'interview#pa',as: :interview_pa,host: REC_DEF
      get '/interview/:personid' => 'interview#details', as: :interview_details,host: REC_DEF
      #requirements
      get '/graduates/requirements' => 'requirements#graduates',as: :requirements_graduates,host: REC_DEF
      get '/career/requirements' => 'requirements#career',as: :requirements_career,host: REC_DEF
      get '/pa/requirements' => 'requirements#pa',as: :requirements_pa,host: REC_DEF
      #entry
      get '/:type/entry' => 'entries#new',as: :entries,host: REC_DEF
      post '/:type/entry' => 'entries#create',as: :post_entries,host: REC_DEF
      get '/mynavi' => redirect('https://job.mynavi.jp/16/pc/search/corp76637/outline.html'),as: :mynavi
      get '/rikunavi' => redirect('http://job.rikunabi.com/2016/company/top/r373520049/'),as: :rikunavi

    end
  end

  #ランディング対策
  constraints lambda {|request| YAMAOKAYA_DOMAINZ.include? request.host} do
    scope module: :brand_yamaokaya do
      #コーポレートへ
      get 'company/index(.:format)' => redirect(UrlHelpers.overview_url)
      get 'company/greetings(.:format)' => redirect(UrlHelpers.greetings_url)
      get 'company/history(.:format)' => redirect(UrlHelpers.history_url)
      get 'company/aniv_25(.:format)' => redirect(UrlHelpers.corp_top_url)

      #メニューページのリダイレクト
      get '/menu/index(.:format)' => redirect(UrlHelpers.menu_categorized_path(:regular))
      constraints category: /[0-9]{1}/ do
        get '/menu/:category(.:format)' => redirect{|params|
          case params[:category].to_i
          when 0
            UrlHelpers.menu_categorized_path(:regular)
          when 1
            UrlHelpers.menu_categorized_path(:std)
          when 2
            UrlHelpers.menu_categorized_path(:limited)
          else
            UrlHelpers.menu_categorized_path(:regular)
          end
        }
        get '/menu/:category/:old_menu_code(.:format)' => redirect{|params|
          case params[:category].to_i
          when 0
            UrlHelpers.menu_categorized_path(:regular)
          when 1
            UrlHelpers.menu_categorized_path(:std)
          when 2
            UrlHelpers.menu_categorized_path(:limited)
          else
            UrlHelpers.menu_categorized_path(:regular)
          end
        }
      end
      #店舗ページのリダイレクト
      get '/shop(.:format)' => redirect(UrlHelpers.shop_root_path)
      constraints old_code: /[0-9]{6}/ do
        get '/shop/:old_code(.:format)' => redirect {|params|
          if params[:old_code].present?
            s = Shop.find_by(old_code: params[:old_code])
            UrlHelpers.shop_details_path(s.id)
          else
            UrlHelpers.shop_root_path
          end
        }
      end
      get '/ir/library(.:format)' => redirect(UrlHelpers.library_url)
    end
  end

  #404
  #get '*path', controller: 'application', action: 'render_404'
  #post '*path', controller: 'application', action: 'render_404'
end
