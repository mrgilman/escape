Escape uses MySQL in development.

To run, just bundle, migrate, and start the server.

For Resque background job, start a Redis server and the following rake tasks:

QUEUE=* bundle exec rake environment resque:scheduler
QUEUE=* bundle exec rake environment resque:work


Easily share what you're up to while you're on vacation. Import an itinerary from TripIt or LivingSocial Escapes, or enter it yourself, then link your social media accounts so that you and your friends can keep track of places you go, things you do, and sites you see.

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mrgilman/escape)