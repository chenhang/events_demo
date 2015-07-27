# Events_demo

events_demo app using Rails 4. Create different events after user do certain things.

# Usage

First clone the repo

```
bundle
bundle exec rake db:setup
bundle exec rspec
rails s
```

Then go to [http://localhost:3000](http://localhost:3000)

# Design

Mainly using concern Eventable to allow different actions of user to create events with different contents.

Every model that could create event implement `event_content()` to generate customized event content for its actions. 

Once action is finished and database is updated, `create_event()` would be called to create a new event with the `event_content()`.

The `events#index` page uses gem `will_paginate` and `JQuery` to allow get next page content when scroll to bottom.