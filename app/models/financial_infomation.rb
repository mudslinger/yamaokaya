class FinancialInfomation
	include ActiveModel::Model
	attr_accessor(
		:year,					#年度
		:sales,					#売上
		:op,					#経常利益
		:ni,					#当期純利益又は当期純損失
		:ioa,					#持分法を適用した場合の投資利益
		:cap,					#資本金
		:ais,					#発行済株式総数
		:na,					#純資産
		:ta,					#総資産
		:bps,					#一株あたり純資産
		:dps,					#1株当たり配当額
		:idps,					#1株当たり中間配当額
		:eps,					#1株当たり当期純利益金額
		:deps,					#潜在株式調整後1株当たり当期純利益金額
		:car,					#自己資本比率
		:roe,					#自己資本利益率
		:per,					#株価収益率
		:dpr,					#配当性向
		:opeCF,					#営業活動によるキャッシュ・フロー
		:invCF,					#投資活動によるキャッシュ・フロー
		:finCF,					#財務活動によるキャッシュ・フロー
		:cce,					#現金及び現金同等物の期末残高
		:employees,				#従業員数
		:parttime				#臨時雇用者数
    )

    #会計期
    def fiscal_period
        "第#{@year - 1994}期"
    end

    def fiscal_period_variant
        "平成#{@year - 1989}年1月期"
    end

    def self.last_5
        find_all.sort do |a,b|
            b.year <=> a.year
        end.take(5)
    end

	def self.find_all
        ret = []
        ret.push FinancialInfomation.new(
            year:2006,
            sales:3998817,
            op:197538,
            ni:93024,
            cap:172647,
            ais:7230,
            na:694018,
            ta:2338894,
            bps:95991.52,
            dps:nil,
            idps:nil,
            eps:13029.2,
            deps:nil,
            car:29.7,
            roe:15.1,
            per:nil,
            dpr:nil,
            opeCF:nil,
            invCF:nil,
            finCF:nil,
            cce:nil,
            employees:240,
            parttime:222,
        )
        ret.push FinancialInfomation.new(
            year:2007,
            sales:5100858,
            op:271226,
            ni:132140,
            cap:172647,
            ais:7230,
            na:829970,
            ta:3058704,
            bps:114795.39,
            dps:nil,
            idps:nil,
            eps:18276.71,
            deps:nil,
            car:27.1,
            roe:17.3,
            per:nil,
            dpr:nil,
            opeCF:332298,
            invCF:-826757,
            finCF:517312,
            cce:205807,
            employees:288,
            parttime:313,
        )
        ret.push FinancialInfomation.new(
            year:2008,
            sales:5959462,
            op:174968,
            ni:85630,
            cap:291647,
            ais:8230,
            na:1211596,
            ta:3757466,
            bps:147217.1,
            dps:5000,
            idps:nil,
            eps:10456.76,
            deps:nil,
            car:32.2,
            roe:8.4,
            per:22.1,
            dpr:47.8,
            opeCF:304772,
            invCF:-892626,
            finCF:573487,
            cce:191440,
            employees:310,
            parttime:374,
        )
        ret.push FinancialInfomation.new(
            year:2009,
            sales:6444178,
            op:92168,
            ni:20270,
            cap:291647,
            ais:8230,
            na:1118299,
            ta:3717489,
            bps:144386.35,
            dps:5000,
            idps:nil,
            eps:2462.98,
            deps:nil,
            car:32,
            roe:1.7,
            per:37.8,
            dpr:203,
            opeCF:338775,
            invCF:-226107,
            finCF:-58256,
            cce:245851,
            employees:303,
            parttime:361,
        )
        ret.push FinancialInfomation.new(
            year:2010,
            sales:7033515,
            op:243433,
            ni:118307,
            cap:291647,
            ais:8230,
            na:1261918,
            ta:4057604,
            bps:153331.57,
            dps:5000,
            idps:nil,
            eps:14375.11,
            deps:nil,
            car:31.1,
            roe:9.4,
            per:6.5,
            dpr:34.8,
            opeCF:589560,
            invCF:-457536,
            finCF:54134,
            cce:432009,
            employees:260,
            parttime:505,
        )
        ret.push FinancialInfomation.new(
            year:2011,
            sales:7223968,
            op:393275,
            ni:207064,
            cap:291647,
            ais:8230,
            na:1430465,
            ta:4556427,
            bps:173509.71,
            dps:5000,
            idps:nil,
            eps:25159.72,
            deps:25098.73,
            car:31.3,
            roe:14.5,
            per:5.1,
            dpr:19.9,
            opeCF:514031,
            invCF:-696615,
            finCF:159937,
            cce:409363,
            employees:245,
            parttime:652,
        )
        ret.push FinancialInfomation.new(
            year:2012,
            sales:7952626,
            op:290018,
            ni:115560,
            cap:291647,
            ais:8230,
            na:1940467,
            ta:5095367,
            bps:182949.02,
            dps:5000,
            idps:nil,
            eps:14172.27,
            deps:14108.25,
            car:29.1,
            roe:7.8,
            per:8.3,
            dpr:35.3,
            opeCF:431171,
            invCF:-1047573,
            finCF:371781,
            cce:164742,
            employees:252,
            parttime:820,
        )
        ret.push FinancialInfomation.new(
            year:2013,
            sales:8712310,
            op:57895,
            ni:-178112,
            cap:291647,
            ais:8230,
            na:1272705,
            ta:5496216,
            bps:1558.95,
            dps:5000,
            idps:nil,
            eps:-219.54,
            deps:nil,
            car:23,
            roe:nil,
            per:nil,
            dpr:nil,
            opeCF:538203,
            invCF:-839986,
            finCF:387820,
            cce:250780,
            employees:282,
            parttime:887,
        )
        ret.push FinancialInfomation.new(
            year:2014,
            sales:8909344,
            op:176058,
            ni:3186,
            cap:291647,
            ais:8230,
            na:1234962,
            ta:5119530,
            bps:1513.03,
            dps:2000,
            idps:nil,
            eps:3.93,
            deps:nil,
            car:24,
            roe:0.3,
            per:211.7,
            dpr:509.1,
            opeCF:620140,
            invCF:-156090,
            finCF:-402269,
            cce:312560,
            employees:260,
            parttime:860,
        )
        ret.push FinancialInfomation.new(
            year:2015,
            sales:8758519,
            op:235662,
            ni:-88128,
            cap:291647,
            ais:823000,
            na:1132516,
            ta:4406269,
            bps:1387.36,
            dps:20,
            idps:nil,
            eps:-108.63,
            deps:nil,
            car:25.5,
            roe:nil,
            per:nil,
            dpr:nil,
            opeCF:613051,
            invCF:12701,
            finCF:-620105,
            cce:318206,
            employees:225,
            parttime:845,
        )
        ret.push FinancialInfomation.new(
            year:2016,
            sales:9007487,
            op:304800, #!#
            ni:114718,
            cap:291647,
            ais:823000,
            na:1226633,
            ta:4519887,
            bps:503.98,
            dps:20,
            idps:nil,
            eps:47.13,
            deps:nil,
            car:27.1,
            roe:9.8,
            per:12.0,
            dpr:14.1,
            opeCF:880558,
            invCF:-209541,
            finCF:-314924,
            cce:674299,
            employees:244,
            parttime:851,
        )

        # :year,                  #年度
        # :sales,                 #売上
        # :op,                    #経常利益
        # :ni,                    #当期純利益又は当期純損失
        # :ioa,                   #持分法を適用した場合の投資利益
        # :cap,                   #資本金
        # :ais,                   #発行済株式総数
        # :na,                    #純資産
        # :ta,                    #総資産
        # :bps,                   #一株あたり純資産
        # :dps,                   #1株当たり配当額
        # :idps,                  #1株当たり中間配当額
        # :eps,                   #1株当たり当期純利益金額
        # :deps,                  #潜在株式調整後1株当たり当期純利益金額
        # :car,                   #自己資本比率
        # :roe,                   #自己資本利益率
        # :per,                   #株価収益率
        # :dpr,                   #配当性向
        # :opeCF,                 #営業活動によるキャッシュ・フロー
        # :invCF,                 #投資活動によるキャッシュ・フロー
        # :finCF,                 #財務活動によるキャッシュ・フロー
        # :cce,                   #現金及び現金同等物の期末残高
        # :employees,             #従業員数
        # :parttime               #臨時雇用者数
        ret.push FinancialInfomation.new(
            year:2017,
            sales:10068512,
            op:539750,
            ni:259890,
            cap:291647,
            ais:2469000,
            na:1468959,
            ta:4913780,
            bps:603.57,
            dps:14,
            idps:nil,
            eps:106.78,
            deps:nil,
            car:29.9,
            roe:19.3,
            per:12.7,
            dpr:13.1,
            opeCF:834311,
            invCF:-640525,
            finCF:-195876,
            cce:672208,
            employees:294,
            parttime:973,
        )

        ret
	end
end
