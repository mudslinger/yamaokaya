# TRANSLATION_STORE = :dalli_store, 'yamaokaya-db.c5uthvjn4chs.ap-northeast-1.rds.amazonaws.com:11211'
# I18n.backend = I18n::Backend::Chain.new(
# 	I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend
# )
# TRANSLATION_STORE = ActiveSupport::Cache::MemCacheStore.new("localhost", "yamaokaya-db.c5uthvjn4chs.ap-northeast-1.rds.amazonaws.com:11211")
# TRANSLATION_STORE = Redis.new(
# 	url:'redis://yamapp-redis.gneihq.0001.apne1.cache.amazonaws.com/yamaokaya/development/cache'
# )

# I18n.backend = 
# 	I18n::Backend::KeyValue.new I18n::Backend::KeyValue.new(TRANSLATION_STORE)
