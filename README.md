# ama_moderator

Ask questions and stuff.

## Required

- DO Buoy Gem

### Google Oauth2 Credentials

ENV variables required for google-oauth2 omniauth:

- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`

Google+ must be enabled.

## Need to Implement

- Add email domain validation to user model (allow restricting to a particular domain)
- My Votes - List of questions voted on by a user (filter by all,up,down), (sort by timestamp, popularity)
- My Questions - List of questions asked by a user (sort by timestamp, popularity)
- Event stats/summary
- Question stats/summary
- Date picker in new/edit Event view (and sort events by scheduled time)
- Update view layouts

- Add google profile images to questions and responses?