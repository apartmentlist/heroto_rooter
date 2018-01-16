module Notification
  class Deploy < Base
    def body
      [
        "#{actor} deployed v#{version}: #{sha}",
        description
      ].compact.join("\n")
    end

    def description
      return if data['description'] =~ /\ADeploy /
      "> #{data['description']}"
    end

    def sha
      data.dig(*%w[slug commit]).first(8)
    end

    def version
      data['version']
    end
  end
end
