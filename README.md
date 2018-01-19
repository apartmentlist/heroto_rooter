
# Heroto Rooter

This is a basic Rails API that routes [Heroku webhook
events](https://devcenter.heroku.com/articles/app-webhooks) to Slack.

## Setup

    git clone https://github.com/apartmentlist/heroto_rooter.git
    bundle install
    rake db:create
    rake db:migrate

## Configuration

### Routing

Routing is set in the `Rooter` objects. Add one with the application name, Slack
channel, and emoji to use as the avatar.

    Rooter.create(
      app: 'heroto-rooter',
      channel: 'log_info',
      emoji: 'speaking_head_in_silhouette'
    )

### Slack

Create a new [bot
integration](https://apartmentlist.slack.com/apps/manage/custom-integrations)
and set the API key into the `SLACK_API_TOKEN` environment varible, which is
read into the
[slack-ruby-client](https://github.com/slack-ruby/slack-ruby-client) in
`config/initializers/slack.rb`.

### Heroku

Heroku needs to know where to send events. You can pick and choose your events
if you like, or subscribe to everything with:

    ./scripts/add_webhooks.rb <host> <app> [app ...]
    
- `host` is your instance's application host, eg. `rooter.example.com`
- `app` is the name (or many names) of the Heroku app to install the webhook on

## Adding new notifications

Notifications are looked up by the `[resource, action]` pair found in an event,
for example `%w[release create]`. To notify about a new event, write a subclass
of `Notification::Base` with the `#body` you want to post, and then add the
class to the `Event::NOTIFICATION_MAP`, keyed by its resource and action.

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

See the [LICENSE](LICENSE.md) file for license rights and limitations.
