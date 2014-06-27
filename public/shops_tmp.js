(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $(function() {
    var AbstractMarker, AreaMarker, PrefMarker, RegionMarker, ShopMarker, areas, map, prefs, regions, shops;
    ShopMarker = (function(_super) {
      __extends(ShopMarker, _super);

      function ShopMarker(local_id, name, map, lat, lng, x, y) {
        this.local_id = local_id;
        this.name = name;
        this.map = map;
        this.lat = lat;
        this.lng = lng;
        if (x == null) {
          x = 0;
        }
        if (y == null) {
          y = 0;
        }
        ShopMarker.__super__.constructor.call(this, {
          position: new google.maps.LatLng(this.lat, this.lng),
          map: this.map,
          title: this.name,
          visible: false,
          icon: new google.maps.MarkerImage("http://assets.yamaokaya.com/images/shops/flags/shops.png", new google.maps.Size(24, 56), new google.maps.Point(x, y))
        });
        google.maps.event.addListener(this.map, 'zoom_changed', (function(_this) {
          return function() {
            var zoom;
            zoom = map.getZoom();
            return _this.setVisible(zoom >= 10);
          };
        })(this));
      }

      return ShopMarker;

    })(google.maps.Marker);
    AbstractMarker = (function(_super) {
      __extends(AbstractMarker, _super);

      function AbstractMarker() {
        return AbstractMarker.__super__.constructor.apply(this, arguments);
      }

      AbstractMarker.prototype.getPosition = function() {
        if (this.position == null) {
          this.position = new google.maps.LatLng(this.lat, this.lng);
        }
        return this.position;
      };

      AbstractMarker.prototype.getBounds = function() {
        if (this.bounds == null) {
          this.bounds = new google.maps.LatLngBounds(new google.maps.LatLng(this.swne.s, this.swne.w), new google.maps.LatLng(this.swne.n, this.swne.e));
        }
        return this.bounds;
      };

      AbstractMarker.prototype.breakdown = function() {
        return this.map.fitBounds(this.getBounds());
      };

      return AbstractMarker;

    })(google.maps.Marker);
    AreaMarker = (function(_super) {
      __extends(AreaMarker, _super);

      function AreaMarker(local_id, name, map, lat, lng, swne) {
        this.local_id = local_id;
        this.name = name;
        this.map = map;
        this.lat = lat;
        this.lng = lng;
        this.swne = swne;
        AreaMarker.__super__.constructor.call(this, {
          position: this.getPosition(),
          map: this.map,
          title: this.name,
          visible: false
        });
        google.maps.event.addListener(this.map, 'zoom_changed', (function(_this) {
          return function() {
            var zoom;
            zoom = map.getZoom();
            return _this.setVisible(zoom >= 9 && zoom < 10);
          };
        })(this));
        google.maps.event.addListener(this, 'click', (function(_this) {
          return function() {
            return _this.breakdown();
          };
        })(this));
      }

      return AreaMarker;

    })(AbstractMarker);
    PrefMarker = (function(_super) {
      __extends(PrefMarker, _super);

      function PrefMarker(local_id, name, map, lat, lng, swne, x, y) {
        this.local_id = local_id;
        this.name = name;
        this.map = map;
        this.lat = lat;
        this.lng = lng;
        this.swne = swne;
        if (x == null) {
          x = 0;
        }
        if (y == null) {
          y = 0;
        }
        PrefMarker.__super__.constructor.call(this, {
          position: this.getPosition(),
          map: this.map,
          title: this.name,
          visible: false,
          icon: new google.maps.MarkerImage("http://assets.yamaokaya.com/images/shops/flags/prefectures.png", new google.maps.Size(24, 56), new google.maps.Point(x, y))
        });
        google.maps.event.addListener(this.map, 'zoom_changed', (function(_this) {
          return function() {
            var zoom;
            zoom = map.getZoom();
            return _this.setVisible(zoom >= 7 && zoom < 9);
          };
        })(this));
        google.maps.event.addListener(this, 'click', (function(_this) {
          return function() {
            return _this.breakdown();
          };
        })(this));
      }

      return PrefMarker;

    })(AbstractMarker);
    RegionMarker = (function(_super) {
      __extends(RegionMarker, _super);

      function RegionMarker(local_id, name, map, lat, lng, swne, x, y) {
        this.local_id = local_id;
        this.name = name;
        this.map = map;
        this.lat = lat;
        this.lng = lng;
        this.swne = swne;
        if (x == null) {
          x = 0;
        }
        if (y == null) {
          y = 0;
        }
        RegionMarker.__super__.constructor.call(this, {
          position: this.getPosition(),
          map: this.map,
          title: this.name,
          icon: new google.maps.MarkerImage("http://assets.yamaokaya.com/images/shops/flags/regions.png", new google.maps.Size(24, 56), new google.maps.Point(x, y))
        });
        google.maps.event.addListener(this.map, 'zoom_changed', (function(_this) {
          return function() {
            var zoom;
            zoom = map.getZoom();
            return _this.setVisible(zoom < 7);
          };
        })(this));
        google.maps.event.addListener(this, 'click', (function(_this) {
          return function() {
            return _this.breakdown();
          };
        })(this));
      }

      return RegionMarker;

    })(AbstractMarker);
    if ($('#index-map').get(0)) {
      map = new google.maps.Map($('#index-map').get(0), {
        zoom: 5,
        center: new google.maps.LatLng(39.7868944, 137.7877029),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        noClear: true
      });
      shops = {
        1119: new ShopMarker(1119, '旭川高砂台店', map, 43.76994843, 142.3120308, 48, 56),
        1125: new ShopMarker(1125, '旭川永山店', map, 43.805559, 142.425675, 192, 56),
        1145: new ShopMarker(1145, '稚内店', map, 45.3849047, 141.7063113, 168, 168),
        1126: new ShopMarker(1126, '上磯店', map, 41.82362873, 140.7100686, 216, 56),
        1128: new ShopMarker(1128, '苫小牧糸井店', map, 42.61673017, 141.5413049, 24, 112),
        1129: new ShopMarker(1129, '室蘭店', map, 42.36341301, 141.057306, 48, 112),
        1134: new ShopMarker(1134, '八雲店', map, 42.256735, 140.280664, 168, 112),
        1135: new ShopMarker(1135, '苫小牧船見店', map, 42.64723763, 141.6268687, 192, 112),
        1142: new ShopMarker(1142, '函館鍛冶店', map, 41.810454, 140.769147, 96, 168),
        1121: new ShopMarker(1121, '釧路店', map, 43.01435229, 144.3193365, 96, 56),
        1122: new ShopMarker(1122, '北見店', map, 43.79809339, 143.8643184, 120, 56),
        1124: new ShopMarker(1124, '帯広店', map, 42.93148202, 143.1931838, 168, 56),
        1130: new ShopMarker(1130, '美幌店', map, 43.81894599, 144.116233, 72, 112),
        1131: new ShopMarker(1131, '伊達店', map, 42.469462, 140.875411, 96, 112),
        1139: new ShopMarker(1139, '帯広南店', map, 42.882326, 143.200698, 24, 168),
        1143: new ShopMarker(1143, '釧路町店', map, 43.013426, 144.403739, 120, 168),
        1144: new ShopMarker(1144, '網走店', map, 43.999815, 144.284241, 144, 168),
        1102: new ShopMarker(1102, '南2条店', map, 43.057967, 141.35621, 0, 0),
        1105: new ShopMarker(1105, '手稲店', map, 43.129596, 141.210969, 48, 0),
        1107: new ShopMarker(1107, '藤野店', map, 42.961548, 141.274245, 72, 0),
        1108: new ShopMarker(1108, '太平店', map, 43.131467, 141.347034, 96, 0),
        1111: new ShopMarker(1111, '東雁来店', map, 43.09158937, 141.4185073, 144, 0),
        1118: new ShopMarker(1118, '新道店', map, 43.104051, 141.378059, 24, 56),
        1132: new ShopMarker(1132, '新すすきの店', map, 43.05360397, 141.353169, 120, 112),
        1137: new ShopMarker(1137, '月寒店', map, 43.01856597, 141.40778, 216, 112),
        1138: new ShopMarker(1138, '大谷地店', map, 43.028084, 141.448481, 0, 168),
        1140: new ShopMarker(1140, '狸小路4丁目店', map, 43.057028, 141.351696, 48, 168),
        1113: new ShopMarker(1113, '恵庭店', map, 42.874185, 141.58404, 168, 0),
        1114: new ShopMarker(1114, '北広島店', map, 42.97346375, 141.56775, 192, 0),
        1117: new ShopMarker(1117, '岩見沢店', map, 43.211573, 141.783987, 0, 56),
        1120: new ShopMarker(1120, '樽川店', map, 43.143939, 141.27656, 72, 56),
        1123: new ShopMarker(1123, '野幌店', map, 43.09410768, 141.5255146, 144, 56),
        1127: new ShopMarker(1127, '滝川店', map, 43.54109868, 141.9229711, 0, 112),
        1133: new ShopMarker(1133, '千歳店', map, 42.82102422, 141.6569727, 144, 112),
        1141: new ShopMarker(1141, '朝里店', map, 43.1747, 141.060097, 72, 168),
        1297: new ShopMarker(1297, '弘前店', map, 40.626162, 140.487464, 48, 728),
        1286: new ShopMarker(1286, '岩手盛岡店', map, 39.680505, 141.155552, 24, 672),
        1232: new ShopMarker(1232, '名取店', map, 38.120094, 140.874987, 168, 336),
        1236: new ShopMarker(1236, '仙台泉区店', map, 38.3504, 140.875056, 24, 392),
        1291: new ShopMarker(1291, '宮城野店', map, 38.276675, 140.990328, 144, 672),
        1288: new ShopMarker(1288, '秋田仁井田店', map, 39.68673, 140.124401, 72, 672),
        1252: new ShopMarker(1252, '山形青田店', map, 38.221139, 140.331326, 168, 448),
        1237: new ShopMarker(1237, 'いわき店', map, 36.986515, 140.902507, 48, 392),
        1249: new ShopMarker(1249, '福島矢野目店', map, 37.789319, 140.460109, 96, 448),
        1294: new ShopMarker(1294, '郡山店', map, 37.426509, 140.343094, 216, 672),
        1201: new ShopMarker(1201, '牛久店', map, 35.999322, 140.153289, 192, 168),
        1202: new ShopMarker(1202, 'つくば店', map, 36.09063092, 140.1445758, 216, 168),
        1203: new ShopMarker(1203, '阿見店', map, 36.04081458, 140.20921, 0, 224),
        1208: new ShopMarker(1208, '土浦店', map, 36.08558438, 140.2060371, 96, 224),
        1210: new ShopMarker(1210, '岩瀬店', map, 36.34831505, 140.0530909, 144, 224),
        1211: new ShopMarker(1211, '結城店', map, 36.28788, 139.884887, 168, 224),
        1214: new ShopMarker(1214, '谷田部店', map, 36.04918138, 140.08496, 0, 280),
        1251: new ShopMarker(1251, '守谷店', map, 35.95988736, 139.986247, 144, 448),
        1263: new ShopMarker(1263, 'つくば中央店', map, 36.076607, 140.105899, 192, 504),
        1269: new ShopMarker(1269, 'かすみがうら店', map, 36.131272, 140.225584, 96, 560),
        1216: new ShopMarker(1216, '水戸南店', map, 36.31240383, 140.4497608, 48, 280),
        1218: new ShopMarker(1218, 'ひたちなか店', map, 36.39767, 140.50526, 96, 280),
        1253: new ShopMarker(1253, '水戸内原店', map, 36.377308, 140.360805, 192, 448),
        1271: new ShopMarker(1271, '水戸城南店', map, 36.366084, 140.482966, 144, 560),
        1281: new ShopMarker(1281, '日立東金沢店', map, 36.538071, 140.636504, 144, 616),
        1204: new ShopMarker(1204, '小山駅南町店', map, 36.29910954, 139.8166786, 24, 224),
        1205: new ShopMarker(1205, '小山田間店', map, 36.26708271, 139.8270762, 48, 224),
        1207: new ShopMarker(1207, '宇都宮鶴田店', map, 36.54263805, 139.8503183, 72, 224),
        1209: new ShopMarker(1209, '壬生店', map, 36.488974, 139.827348, 120, 224),
        1213: new ShopMarker(1213, '宇都宮長岡店', map, 36.59735486, 139.884955, 216, 224),
        1220: new ShopMarker(1220, '足利店', map, 36.30791896, 139.4632151, 144, 280),
        1244: new ShopMarker(1244, '佐野店', map, 36.296089, 139.601482, 216, 392),
        1299: new ShopMarker(1299, 'テクノポリスセンター店', map, 36.567589, 139.993833, 96, 728),
        1217: new ShopMarker(1217, '太田店', map, 36.34358296, 139.3831464, 72, 280),
        1223: new ShopMarker(1223, '高崎西店', map, 36.33416332, 138.9466527, 216, 280),
        1225: new ShopMarker(1225, '伊勢崎宮子店', map, 36.329068, 139.167193, 0, 336),
        1230: new ShopMarker(1230, '高崎倉賀野店', map, 36.29476338, 139.0695367, 120, 336),
        1231: new ShopMarker(1231, '前橋亀里店', map, 36.344258, 139.089974, 144, 336),
        1233: new ShopMarker(1233, '高崎中尾店', map, 36.370072, 139.023349, 192, 336),
        1212: new ShopMarker(1212, '春日部店', map, 35.95499724, 139.7263575, 192, 224),
        1228: new ShopMarker(1228, '吹上店', map, 36.10068042, 139.4650467, 72, 336),
        1229: new ShopMarker(1229, '狭山店', map, 35.84781635, 139.3925235, 96, 336),
        1235: new ShopMarker(1235, '熊谷店', map, 36.180499, 139.325466, 0, 392),
        1238: new ShopMarker(1238, '上尾店', map, 35.994249, 139.576449, 72, 392),
        1241: new ShopMarker(1241, '鷲宮店', map, 36.097492, 139.67457, 144, 392),
        1247: new ShopMarker(1247, 'さいたま宮前店', map, 35.924356, 139.58399, 48, 448),
        1258: new ShopMarker(1258, 'さいたま丸ヶ崎店', map, 35.958397, 139.656124, 72, 504),
        1275: new ShopMarker(1275, '越谷レイクタウン店', map, 35.884252, 139.817204, 0, 616),
        1277: new ShopMarker(1277, '東松山店', map, 36.030668, 139.419572, 48, 616),
        1215: new ShopMarker(1215, '柏店', map, 35.893786, 139.958737, 24, 280),
        1245: new ShopMarker(1245, '野田店', map, 35.937266, 139.890091, 0, 448),
        1221: new ShopMarker(1221, '千葉中央区店', map, 35.551812, 140.12526, 168, 280),
        1222: new ShopMarker(1222, '木更津店', map, 35.395269, 139.941884, 192, 280),
        1227: new ShopMarker(1227, '君津店', map, 35.325492, 139.924326, 48, 336),
        1261: new ShopMarker(1261, '八千代店', map, 35.771384, 140.095156, 144, 504),
        1262: new ShopMarker(1262, '東千葉店', map, 35.626939, 140.126662, 168, 504),
        1283: new ShopMarker(1283, '千葉若葉区店', map, 35.637067, 140.166761, 192, 616),
        1284: new ShopMarker(1284, '千葉鎌ヶ谷店', map, 35.777592, 140.002095, 216, 616),
        4224: new ShopMarker(4224, '千葉花見川区店', map, 35.684051, 140.128222, 24, 784),
        1219: new ShopMarker(1219, '成田店', map, 35.79445322, 140.3191661, 120, 280),
        1267: new ShopMarker(1267, '成田飯仲店', map, 35.757466, 140.302534, 48, 560),
        1280: new ShopMarker(1280, '東金店', map, 35.554273, 140.365338, 120, 616),
        1287: new ShopMarker(1287, '千葉佐倉店', map, 35.713634, 140.219311, 48, 672),
        1226: new ShopMarker(1226, '瑞穂店', map, 35.765144, 139.354159, 24, 336),
        1239: new ShopMarker(1239, '厚木店', map, 35.48839022, 139.3648881, 96, 392),
        1254: new ShopMarker(1254, '相模原店', map, 35.562957, 139.346557, 216, 448),
        1260: new ShopMarker(1260, '平塚店', map, 35.356209, 139.357184, 120, 504),
        1246: new ShopMarker(1246, '笛吹店', map, 35.642859, 138.645487, 24, 448),
        1278: new ShopMarker(1278, '山梨甲斐店', map, 35.660467, 138.521767, 72, 616),
        1292: new ShopMarker(1292, 'フォレスト河口湖店', map, 35.490429, 138.746552, 168, 672),
        1276: new ShopMarker(1276, '長野南長池店', map, 36.641922, 138.237319, 24, 616),
        1289: new ShopMarker(1289, '松本店', map, 36.184544, 137.963111, 96, 672),
        1300: new ShopMarker(1300, '金沢森戸店', map, 36.559493, 136.598795, 120, 728),
        1242: new ShopMarker(1242, '岐阜瑞穂店', map, 35.388352, 136.694748, 168, 392),
        1243: new ShopMarker(1243, '大垣店', map, 35.317209, 136.618516, 192, 392),
        1234: new ShopMarker(1234, '富士店', map, 35.135111, 138.652831, 216, 336),
        1268: new ShopMarker(1268, '沼津柿田川店', map, 35.108818, 138.896839, 72, 560),
        1295: new ShopMarker(1295, '富士宮店', map, 35.243448, 138.618375, 0, 728),
        1248: new ShopMarker(1248, '浜松有玉店', map, 34.759208, 137.7527, 72, 448),
        1250: new ShopMarker(1250, '浜松入野店', map, 34.697493, 137.684497, 120, 448),
        1264: new ShopMarker(1264, '浜松薬師店', map, 34.725332, 137.779249, 216, 504),
        1296: new ShopMarker(1296, '浜松南区店', map, 34.677547, 137.680723, 24, 728),
        1255: new ShopMarker(1255, '豊橋下地店', map, 34.77823872, 137.3852641, 0, 504),
        1256: new ShopMarker(1256, '大口店', map, 35.325492, 136.917391, 24, 504),
        1270: new ShopMarker(1270, '音羽蒲郡店', map, 34.855325, 137.312496, 120, 560),
        1290: new ShopMarker(1290, '愛知刈谷店', map, 35.006077, 137.003347, 120, 672),
        1257: new ShopMarker(1257, '桑名店', map, 35.041357, 136.691814, 48, 504),
        1303: new ShopMarker(1303, '京都八幡店', map, 34.856474, 135.709407, 192, 728),
        1302: new ShopMarker(1302, '岸和田店', map, 34.451732, 135.434357, 168, 728),
        1301: new ShopMarker(1301, '明石店', map, 34.653328, 134.97586, 144, 728),
        1304: new ShopMarker(1304, '北九州店', map, 33.910894, 130.806838, 216, 728),
        1305: new ShopMarker(1305, '熊本店', map, 32.774459, 130.695162, 0, 784)
      };
      areas = {
        251876111: new AreaMarker(251876111, '北海道', map, 43.196353950033334, 141.91591244683335, {
          s: 43.820137376666666667,
          w: 141.497559866666666667,
          n: 42.75303309,
          e: 144.0321450875
        }),
        178846862: new AreaMarker(178846862, '青森県', map, 40.626162, 140.487464, {
          s: 40.126162,
          w: 140.987464,
          n: 41.126162,
          e: 140.987464
        }),
        460780088: new AreaMarker(460780088, '岩手県', map, 39.680505, 141.155552, {
          s: 39.180505,
          w: 141.655552,
          n: 40.180505,
          e: 141.655552
        }),
        276480649: new AreaMarker(276480649, '宮城県', map, 38.249056333333336, 140.913457, {
          s: 37.749056333333333333,
          w: 141.413457,
          n: 38.749056333333333333,
          e: 141.413457
        }),
        951567475: new AreaMarker(951567475, '秋田県', map, 39.68673, 140.124401, {
          s: 39.18673,
          w: 140.624401,
          n: 40.18673,
          e: 140.624401
        }),
        902222700: new AreaMarker(902222700, '山形県', map, 38.221139, 140.331326, {
          s: 37.721139,
          w: 140.831326,
          n: 38.721139,
          e: 140.831326
        }),
        312346209: new AreaMarker(312346209, '福島県', map, 37.400781, 140.56857, {
          s: 36.900781,
          w: 141.06857,
          n: 37.900781,
          e: 141.06857
        }),
        409502837: new AreaMarker(409502837, '茨城県', map, 36.2526284165, 140.29621857, {
          s: 35.898307366,
          w: 140.60537798,
          n: 36.606949467,
          e: 140.98705916
        }),
        87920779: new AreaMarker(87920779, '栃木県', map, 36.420844515, 139.783113275, {
          s: 35.920844515,
          w: 140.283113275,
          n: 36.920844515,
          e: 140.283113275
        }),
        427732704: new AreaMarker(427732704, '群馬県', map, 36.33598461, 139.11330863333333, {
          s: 35.83598461,
          w: 139.613308633333333333,
          n: 36.83598461,
          e: 139.613308633333333333
        }),
        281546484: new AreaMarker(281546484, '埼玉県', map, 35.997340701, 139.56373027, {
          s: 35.497340701,
          w: 140.06373027,
          n: 36.497340701,
          e: 140.06373027
        }),
        207260971: new AreaMarker(207260971, '千葉県', map, 35.738894435, 140.09659900833333, {
          s: 35.415526,
          w: 140.424414,
          n: 36.09620075,
          e: 140.801587275
        }),
        239586547: new AreaMarker(239586547, '東京都', map, 35.765144, 139.354159, {
          s: 35.265144,
          w: 139.854159,
          n: 36.265144,
          e: 139.854159
        }),
        652330067: new AreaMarker(652330067, '神奈川県', map, 35.46918540666667, 139.3562097, {
          s: 34.969185406666666667,
          w: 139.8562097,
          n: 35.969185406666666667,
          e: 139.8562097
        }),
        591274234: new AreaMarker(591274234, '新潟県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        635733970: new AreaMarker(635733970, '山梨県', map, 35.59791833333333, 138.63793533333333, {
          s: 35.097918333333333333,
          w: 139.137935333333333333,
          n: 36.097918333333333333,
          e: 139.137935333333333333
        }),
        788120892: new AreaMarker(788120892, '長野県', map, 36.413233, 138.100215, {
          s: 36.141922,
          w: 138.463111,
          n: 36.684544,
          e: 138.737319
        }),
        265749711: new AreaMarker(265749711, '富山県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        947542449: new AreaMarker(947542449, '石川県', map, 36.559493, 136.598795, {
          s: 36.059493,
          w: 137.098795,
          n: 37.059493,
          e: 137.098795
        }),
        773150162: new AreaMarker(773150162, '福井県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        326871454: new AreaMarker(326871454, '岐阜県', map, 35.3527805, 136.656632, {
          s: 34.8527805,
          w: 137.156632,
          n: 35.8527805,
          e: 137.156632
        }),
        15454840: new AreaMarker(15454840, '静岡県', map, 34.938677, 138.22348695833332, {
          s: 34.662459,
          w: 138.22429225,
          n: 35.214895,
          e: 139.222681666666666667
        }),
        931486790: new AreaMarker(931486790, '愛知県', map, 34.99128318, 137.154624525, {
          s: 34.49128318,
          w: 137.654624525,
          n: 35.49128318,
          e: 137.654624525
        }),
        917095512: new AreaMarker(917095512, '三重県', map, 35.041357, 136.691814, {
          s: 34.541357,
          w: 137.191814,
          n: 35.541357,
          e: 137.191814
        }),
        298708722: new AreaMarker(298708722, '滋賀県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        723653236: new AreaMarker(723653236, '京都府', map, 34.856474, 135.709407, {
          s: 34.356474,
          w: 136.209407,
          n: 35.356474,
          e: 136.209407
        }),
        291723847: new AreaMarker(291723847, '大阪府', map, 34.451732, 135.434357, {
          s: 33.951732,
          w: 135.934357,
          n: 34.951732,
          e: 135.934357
        }),
        225257782: new AreaMarker(225257782, '兵庫県', map, 34.653328, 134.97586, {
          s: 34.153328,
          w: 135.47586,
          n: 35.153328,
          e: 135.47586
        }),
        336901251: new AreaMarker(336901251, '奈良県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        500411378: new AreaMarker(500411378, '和歌山県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        1040886171: new AreaMarker(1040886171, '鳥取県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        915853557: new AreaMarker(915853557, '島根県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        322390069: new AreaMarker(322390069, '岡山県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        558039417: new AreaMarker(558039417, '広島県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        732530182: new AreaMarker(732530182, '山口県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        1037255030: new AreaMarker(1037255030, '徳島県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        42782872: new AreaMarker(42782872, '香川県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        66035809: new AreaMarker(66035809, '愛媛県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        408820544: new AreaMarker(408820544, '高知県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        600916895: new AreaMarker(600916895, '福岡県', map, 33.910894, 130.806838, {
          s: 33.410894,
          w: 131.306838,
          n: 34.410894,
          e: 131.306838
        }),
        30596567: new AreaMarker(30596567, '佐賀県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        1054445149: new AreaMarker(1054445149, '長崎県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        441630090: new AreaMarker(441630090, '熊本県', map, 32.774459, 130.695162, {
          s: 32.274459,
          w: 131.195162,
          n: 33.274459,
          e: 131.195162
        }),
        887170523: new AreaMarker(887170523, '大分県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        124644287: new AreaMarker(124644287, '宮崎県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        1053660527: new AreaMarker(1053660527, '鹿児島県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }),
        514102802: new AreaMarker(514102802, '沖縄県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        })
      };
      prefs = {
        251876111: new PrefMarker(251876111, '北海道', map, 43.196353950033334, 141.91591244683335, {
          s: 43.820137376666666667,
          w: 141.497559866666666667,
          n: 42.75303309,
          e: 144.0321450875
        }, 0, 0),
        178846862: new PrefMarker(178846862, '青森県', map, 40.626162, 140.487464, {
          s: 40.126162,
          w: 140.987464,
          n: 41.126162,
          e: 140.987464
        }, 24, 0),
        460780088: new PrefMarker(460780088, '岩手県', map, 39.680505, 141.155552, {
          s: 39.180505,
          w: 141.655552,
          n: 40.180505,
          e: 141.655552
        }, 48, 0),
        276480649: new PrefMarker(276480649, '宮城県', map, 38.249056333333336, 140.913457, {
          s: 37.749056333333333333,
          w: 141.413457,
          n: 38.749056333333333333,
          e: 141.413457
        }, 72, 0),
        951567475: new PrefMarker(951567475, '秋田県', map, 39.68673, 140.124401, {
          s: 39.18673,
          w: 140.624401,
          n: 40.18673,
          e: 140.624401
        }, 96, 0),
        902222700: new PrefMarker(902222700, '山形県', map, 38.221139, 140.331326, {
          s: 37.721139,
          w: 140.831326,
          n: 38.721139,
          e: 140.831326
        }, 120, 0),
        312346209: new PrefMarker(312346209, '福島県', map, 37.400781, 140.56857, {
          s: 36.900781,
          w: 141.06857,
          n: 37.900781,
          e: 141.06857
        }, 144, 0),
        409502837: new PrefMarker(409502837, '茨城県', map, 36.2526284165, 140.29621857, {
          s: 35.898307366,
          w: 140.60537798,
          n: 36.606949467,
          e: 140.98705916
        }, 168, 0),
        87920779: new PrefMarker(87920779, '栃木県', map, 36.420844515, 139.783113275, {
          s: 35.920844515,
          w: 140.283113275,
          n: 36.920844515,
          e: 140.283113275
        }, 192, 0),
        427732704: new PrefMarker(427732704, '群馬県', map, 36.33598461, 139.11330863333333, {
          s: 35.83598461,
          w: 139.613308633333333333,
          n: 36.83598461,
          e: 139.613308633333333333
        }, 216, 0),
        281546484: new PrefMarker(281546484, '埼玉県', map, 35.997340701, 139.56373027, {
          s: 35.497340701,
          w: 140.06373027,
          n: 36.497340701,
          e: 140.06373027
        }, 0, 56),
        207260971: new PrefMarker(207260971, '千葉県', map, 35.738894435, 140.09659900833333, {
          s: 35.415526,
          w: 140.424414,
          n: 36.09620075,
          e: 140.801587275
        }, 24, 56),
        239586547: new PrefMarker(239586547, '東京都', map, 35.765144, 139.354159, {
          s: 35.265144,
          w: 139.854159,
          n: 36.265144,
          e: 139.854159
        }, 48, 56),
        652330067: new PrefMarker(652330067, '神奈川県', map, 35.46918540666667, 139.3562097, {
          s: 34.969185406666666667,
          w: 139.8562097,
          n: 35.969185406666666667,
          e: 139.8562097
        }, 72, 56),
        591274234: new PrefMarker(591274234, '新潟県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 96, 56),
        635733970: new PrefMarker(635733970, '山梨県', map, 35.59791833333333, 138.63793533333333, {
          s: 35.097918333333333333,
          w: 139.137935333333333333,
          n: 36.097918333333333333,
          e: 139.137935333333333333
        }, 192, 56),
        788120892: new PrefMarker(788120892, '長野県', map, 36.413233, 138.100215, {
          s: 36.141922,
          w: 138.463111,
          n: 36.684544,
          e: 138.737319
        }, 216, 56),
        265749711: new PrefMarker(265749711, '富山県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 120, 56),
        947542449: new PrefMarker(947542449, '石川県', map, 36.559493, 136.598795, {
          s: 36.059493,
          w: 137.098795,
          n: 37.059493,
          e: 137.098795
        }, 144, 56),
        773150162: new PrefMarker(773150162, '福井県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 168, 56),
        326871454: new PrefMarker(326871454, '岐阜県', map, 35.3527805, 136.656632, {
          s: 34.8527805,
          w: 137.156632,
          n: 35.8527805,
          e: 137.156632
        }, 0, 112),
        15454840: new PrefMarker(15454840, '静岡県', map, 34.938677, 138.22348695833332, {
          s: 34.662459,
          w: 138.22429225,
          n: 35.214895,
          e: 139.222681666666666667
        }, 24, 112),
        931486790: new PrefMarker(931486790, '愛知県', map, 34.99128318, 137.154624525, {
          s: 34.49128318,
          w: 137.654624525,
          n: 35.49128318,
          e: 137.654624525
        }, 48, 112),
        917095512: new PrefMarker(917095512, '三重県', map, 35.041357, 136.691814, {
          s: 34.541357,
          w: 137.191814,
          n: 35.541357,
          e: 137.191814
        }, 72, 112),
        298708722: new PrefMarker(298708722, '滋賀県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 96, 112),
        723653236: new PrefMarker(723653236, '京都府', map, 34.856474, 135.709407, {
          s: 34.356474,
          w: 136.209407,
          n: 35.356474,
          e: 136.209407
        }, 120, 112),
        291723847: new PrefMarker(291723847, '大阪府', map, 34.451732, 135.434357, {
          s: 33.951732,
          w: 135.934357,
          n: 34.951732,
          e: 135.934357
        }, 144, 112),
        225257782: new PrefMarker(225257782, '兵庫県', map, 34.653328, 134.97586, {
          s: 34.153328,
          w: 135.47586,
          n: 35.153328,
          e: 135.47586
        }, 168, 112),
        336901251: new PrefMarker(336901251, '奈良県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 192, 112),
        500411378: new PrefMarker(500411378, '和歌山県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 216, 112),
        1040886171: new PrefMarker(1040886171, '鳥取県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 0, 168),
        915853557: new PrefMarker(915853557, '島根県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 24, 168),
        322390069: new PrefMarker(322390069, '岡山県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 48, 168),
        558039417: new PrefMarker(558039417, '広島県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 72, 168),
        732530182: new PrefMarker(732530182, '山口県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 96, 168),
        1037255030: new PrefMarker(1037255030, '徳島県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 120, 168),
        42782872: new PrefMarker(42782872, '香川県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 144, 168),
        66035809: new PrefMarker(66035809, '愛媛県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 168, 168),
        408820544: new PrefMarker(408820544, '高知県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 192, 168),
        600916895: new PrefMarker(600916895, '福岡県', map, 33.910894, 130.806838, {
          s: 33.410894,
          w: 131.306838,
          n: 34.410894,
          e: 131.306838
        }, 216, 168),
        30596567: new PrefMarker(30596567, '佐賀県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 0, 224),
        1054445149: new PrefMarker(1054445149, '長崎県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 24, 224),
        441630090: new PrefMarker(441630090, '熊本県', map, 32.774459, 130.695162, {
          s: 32.274459,
          w: 131.195162,
          n: 33.274459,
          e: 131.195162
        }, 48, 224),
        887170523: new PrefMarker(887170523, '大分県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 72, 224),
        124644287: new PrefMarker(124644287, '宮崎県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 96, 224),
        1053660527: new PrefMarker(1053660527, '鹿児島県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 120, 224),
        514102802: new PrefMarker(514102802, '沖縄県', map, {
          s: 0,
          w: 0,
          n: 0,
          e: 0
        }, 144, 224)
      };
      return regions = {
        251876111: new RegionMarker(251876111, '北海道地方', map, 42.7827, 142.532, {
          s: 42.6963539500333333334,
          w: 142.4159124468333333334,
          n: 43.6963539500333333334,
          e: 142.4159124468333333334
        }, 0, 0),
        560753350: new RegionMarker(560753350, '東北地方', map, 39.1476, 141.01, {
          s: 40.126162,
          w: 140.624401,
          n: 37.900781,
          e: 141.655552
        }, 24, 0),
        1062012727: new RegionMarker(1062012727, '関東地方', map, 35.6928, 139.732, {
          s: 35.920844515,
          w: 139.613308633333333333,
          n: 35.969185406666666667,
          e: 140.79621857
        }, 48, 0),
        559264498: new RegionMarker(559264498, '甲信越地方', map, 37.1949, 138.526, {
          s: 35.913233,
          w: 138.600215,
          n: 36.097918333333333333,
          e: 139.137935333333333333
        }, 72, 0),
        679831339: new RegionMarker(679831339, '北陸地方', map, 36.6643, 136.86, {
          s: 36.059493,
          w: 137.098795,
          n: 37.059493,
          e: 137.098795
        }, 96, 0),
        624947614: new RegionMarker(624947614, '東海地方', map, 35.173, 136.847, {
          s: 34.8527805,
          w: 137.156632,
          n: 35.438677,
          e: 138.7234869583333333335
        }, 120, 0),
        515933300: new RegionMarker(515933300, '近畿地方', map, 34.6784, 135.495, {
          s: 34.356474,
          w: 135.47586,
          n: 34.951732,
          e: 136.209407
        }, 144, 0),
        539901505: new RegionMarker(539901505, '九州地方', map, 32.9858, 131.794, {
          s: 33.410894,
          w: 131.195162,
          n: 33.274459,
          e: 131.306838
        }, 216, 0)
      };
    }
  });

}).call(this);