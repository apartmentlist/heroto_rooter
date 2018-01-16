#!/usr/bin/env ruby

RESOURCES = %w[
  api:addon-attachment
  api:addon
  api:app
  api:build
  api:collaborator
  api:domain
  api:dyno
  api:formation
  api:release
  api:sni-endpoint
  api:ssl-endpoint
]

URL = 'https://heroto-rooter.herokuapp.com/events'

def cmd(app)
  <<-CMD.gsub(/\s+/x, ' ').strip
    heroku webhooks:add
    --include #{RESOURCES.join(',')}
    --level sync
    --url #{URL}
    --app #{app}
  CMD
end

apps = ARGV.to_a

if apps.empty?
  puts "Usage: #{__FILE__} app [app ...]"
  exit 1
end

apps.each do |app|
  system(cmd(app))
end
