redis_host = ENV['REDIS_HOST'] || "192.168.99.100"
redis_port = ENV['REDIS_PORT'] || "32777"

Resque.redis = Redis.new(:host => redis_host, :port => redis_port, :thread_safe => true)
Resque.schedule = YAML.load_file("config/scheduler.yml")
