AWS_CREDENTIALS =  JSON.parse(RestClient.get 'http://192.168.11.30:7700/ssconnect/trigger/aws/credentials.json', {:accept => :json})
