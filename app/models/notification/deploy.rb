module Notification
  class Deploy < Base
    def body
      "Deployed v#{version}: #{sha}"
    end

    def data
      event.payload['data']
    end

    def sha
      data.dig(*%w[slug commit]).first(8)
    end

    def version
      data['version']
    end
  end
end
