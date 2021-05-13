Rails.application.config.session_store :redis_store,
  servers: [
      {
          host: Settings.redis_host || 'localhost' ,
          port: Settings.redis_port || 6378,
          db: 0,
          namespace: 'session'
      }
  ],
  expire_after: 90.minutes
