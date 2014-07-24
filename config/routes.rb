Rails.application.routes.draw do
  #common
  get '/about' => 'articles#about',as: :about
  get '/sns_guideline' => 'articles#sns_guideline',as: :sns_guideline
  get '/sitemap' => 'articles#sitemap',as: :sitemap
  get '/mag_faq' => 'articles#mag_faq', as: :mag_faq
  get '/google_map/:address' => redirect("https://maps.google.co.jp/maps?q=%{address}"),as: :google_map

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
      get '/business/yamaokaya/ict' => 'business#ict',as: :ict

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
end
