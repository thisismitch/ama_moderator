# ama_moderator

Ask questions and stuff.

## Required

### DO Buoy Gem

Currently, the buoy gem is not publicly available.

If the server can't access the private buoy github repo, you must build the gem, install it on your system, then bundle.


In the buoy project, build and install the gem:

```
gem build buoy.gemspec
gem install buoy-0.0.1.gem
```

## How to Deploy

### Set Env Variables

#### Google Oauth2 Credentials

ENV variables required for google-oauth2 omniauth:

- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`

Google+ API must be enabled for your application.

#### Devise Secret

In production, ENV variable for Devise secret key must be set:

- `DEVISE_SECRET`

#### Production Postgres Database Creds

- `APP_DATABASE_USER`
- `APP_DATABASE_PASSWORD`

#### Hosted Domain

To restrict Google OAuth2 to a particular hosted domain, set the **HD** environment variable to the domain. For example, "export HD=domain.com" will only allow "domain.com" addresses to pass Google OAuth2.

### Rake stuff

```
RAILS_ENV=production rake assets:precompile
RAILS_ENV=production rake db:create
RAILS_ENV=production rake db:migrate
```

### Start Server

Start the server.

Log in to create your user. Then make yourself admin and create an anonymous user:

```
RAILS_ENV=production rake db:seed
```

## Need to Implement

- My Votes - List of questions voted on by a user (filter by all,up,down), (sort by timestamp, popularity)
- Date picker in new/edit Event view (and sort events by scheduled time)

## Author

Mitchell Anicas thisismitch@gmail.com / manicas@digitalocean.com