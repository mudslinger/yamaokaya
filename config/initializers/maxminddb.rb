# Download latest free geo city database from here:
# http://dev.maxmind.com/geoip/geoip2/geolite2/
Maxminddb = MaxMindDB.new(Rails.root.join('./lib/db/GeoLite2-City.mmdb'))