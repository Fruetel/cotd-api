class Environment
  class << self
    def env
      ENV['ENV'] || 'development'
    end
  end
end
