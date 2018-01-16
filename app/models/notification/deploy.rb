module Notification
  class Deploy < Base
    def body
      "#{actor} deployed v#{version}: #{sha}"
    end

    def sha
      data.dig(*%w[slug commit]).first(8)
    end

    def version
      data['version']
    end
  end
end
