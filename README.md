# ama_moderator

Ask questions and stuff.

## Required

- DO Buoy Gem

### Google Oauth2 Credentials

ENV variables required for google-oauth2 omniauth:

- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`

Google+ API must be enabled for your application.

### Devise Secret

In production, ENV variable for Devise secret key must be set:

- `DEVISE_SECRET`

For example, `export DEVISE_SECRET='fb1a9c20d9389e4354b11d96b44faee82a741249dc4a1178fede7c26b05a90417f4a18ccc9fd45af06e9bdc486c4edad01bc69617d7ef4f7a516bd3a41983a7c'`

## Notes


### Email Domain Validation

To restrict Google OAuth2 to a particular hosted domain, set the **HD** environment variable to the domain. For example, "export HD=domain.com" will only allow "domain.com" addresses to pass Google OAuth2.

## Need to Implement

- My Votes - List of questions voted on by a user (filter by all,up,down), (sort by timestamp, popularity)
- My Questions - List of questions asked by a user (sort by timestamp, popularity)
- Event stats/summary
- Question stats/summary
- Date picker in new/edit Event view (and sort events by scheduled time)
- Update view layouts

- Add google profile images to questions and responses?
- Add usage messages