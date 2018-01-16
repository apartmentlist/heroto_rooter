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

apps = ARGV.to_a
ROOTER_HOST = apps.shift
URL = "https://#{ROOTER_HOST}/events"

def cmd(app)
  <<-CMD.gsub(/\s+/x, ' ').strip
    heroku webhooks:add
    --include #{RESOURCES.join(',')}
    --level sync
    --url #{URL}
    --app #{app}
  CMD
end

if apps.empty?
  puts "Usage: #{__FILE__} <rooter_host> <app> [app ...]"
  puts "Eg: #{__FILE__} rooter.example.com my-app"
  exit 1
end

apps.each do |app|
  system(cmd(app))
end
