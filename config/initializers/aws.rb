AWS_CREDENTIALS =  JSON.parse(RestClient.get 'http://neptune:7700/ssconnect/trigger/aws/credentials.json', {:accept => :json})

