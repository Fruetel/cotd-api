class Environment
  class << self
    def env
      ENV['ENV'] || 'development'
    end

    def test_env?
      env == 'test'
    end
  end
end
