Rails.application.config.session_store :redis_store, url: Settings.redis.url, namespace: 'session', expire_after: 1.weeks
