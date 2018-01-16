module Notification
  class Scale < Base
    def body
      "#{actor} scaled #{data['type']} to #{data['quantity']}:#{data['size']}"
    end
  end
end
