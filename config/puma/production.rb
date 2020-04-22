workers Integer(ENV['WEB_CONCURRENCY'] || 0)
threads Integer(ENV['WEB_THREADS_MIN'] || 0),
        Integer(ENV['WEB_THREADS_MAX'] || 16)

rackup DefaultRackup

directory File.expand_path('.')
preload_app!
