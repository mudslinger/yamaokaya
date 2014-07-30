Rails.application.routes.draw do

  #common
  get '/about' => 'articles#about',as: :about
  get '/sns_guideline' => 'articles#sns_guideline',as: :sns_guideline
  get '/sitemap' => 'articles#sitemap',as: :sitemap
  get '/mag_faq' => 'articles#mag_faq', as: :mag_faq
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
  constraints host: DOMAINS[:corporate] do
    scope module: :corporate do
      get '/' => 'top#index',as: :corp_top
      get '/index(.:format)' => 'top#index',as: :corp_top_variant
      get '/greetings' => 'top#greetings',as: :greetings
      get '/company/history' => 'company#history',as: :history
      get '/company/overview' => 'company#overview',as: :overview
      get '/business/yamaokaya' => 'business#yamaokaya',as: :business
      get '/business/yamaokaya/products' => 'business#products',as: :products
      get '/business/yamaokaya/hospitality' => 'business#hospitality',as: :hospitality
      get '/business/yamaokaya/safety' => 'business#safety',as: :safety
      get '/business/yamaokaya/development' => 'business#development',as: :development
      # get '/business/yamaokaya/ict' => 'business#ict',as: :ict

      get '/ir' => 'ir#index',as: :ir_top
      get '/ir/market' => 'ir#market',as: :market
      get '/ir/highlight' => 'ir#highlight',as: :highlight
      get '/ir/library' => 'ir#library',as: :library
      # get '/ir/infomation' => 'ir#infomation',as: :infomation
      get '/ir/calender' => 'ir#calender',as: :calender
      get '/ir/disclaimer' => 'ir#disclaimer',as: :disclaimer
      get '/ir/financial_infomation' => 'ir#financial_info',as: :financial_info
      get '/property' => 'property#development',as: :property
    end
  end

  constraints host: DOMAINS[:yamaokaya] do
    scope module: :brand_yamaokaya do
      get '/' => 'top#index',as: :yamaokaya_top
      get '/index(.:format)' => 'top#index',as: :yamaokaya_top_variant
      get '/shops/:key' => 'shops#details', as: :shop_details
      get 'shops' => 'shops#shops', as: :shop_root
      get 'big_map' => 'shops#big_map'
      constraints id: /[0-9]+/ do
        get 'menus/:id' => 'menus#details',as: :menu_details
      end
      get 'menus/:category' => 'menus#categorized', as: :menu_categorized 

    end 
  end

  constraints host: DOMAINS[:recruit] do
    scope module: :recruit do
      get '/' => 'top#index',as: :recruit_top
      get '/index(.:format)' => 'top#index',as: :recruit_top_variant

      #message
      get '/graduates/message' => 'message#graduates',as: :message_graduates
      get '/career/message' => 'message#career',as: :message_career
      get '/pa/message' => 'message#pa',as: :message_pa
      #interview
      get '/graduates/interview' => 'interview#graduates',as: :interview_graduates
      get '/career/interview' => 'interview#career',as: :interview_career
      get '/pa/interview' => 'interview#pa',as: :interview_pa
      get '/interview/:personid' => 'interview#details', as: :interview_details
      #requirements
      get '/graduates/requirements' => 'requirements#graduates',as: :requirements_graduates
      get '/career/requirements' => 'requirements#career',as: :requirements_career
      get '/pa/requirements' => 'requirements#pa',as: :requirements_pa
      #entry
      get '/:type/entry' => 'entries#new',as: :entries
      post '/:type/entry' => 'entries#create',as: :post_entries
      get '/rikunabi' => redirect('http://job.rikunabi.com/2016/company/top/r373520049/'),as: :rikunavi
    end 
  end

  #ランディング用エイリアス
  constraints host: DOMAINS[:yamaokaya] do
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
  get '*path', controller: 'application', action: 'render_404'
  post '*path', controller: 'application', action: 'render_404'
end
