Escape uses MySQL in development.

To run, bundle, migrate, and start the server.
To run tests, rake spec.

For Resque background job, start a Redis server and the following rake tasks:

QUEUE=* bundle exec rake environment resque:scheduler  
QUEUE=* bundle exec rake environment resque:work

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mrgilman/escape)