# SPOT SMS Nofifier

## Background

This December I had opportunity to sail with friends from NYC to Norfolk, VA on a 44 foot sloop called the songbird.  Two of us got off in Norfolk and they recrewed for a trip to the Virgin Islands, leaving only a SPOT ( http://www.findmespot.com/ ) beacon and a webpage to find them by.

Wanting to keep better progress of their Journey, I whipped this up over the weekend.  This application:

- Checks any SPOT Feed ID for new messages
- Sends messages to any phone number via Twillio.

Enjoy!

## Usage

To use this:
- Copy config/database.yml.example to config/database.yml and fill in your credentials.
- Once the database is created, run rake:db migrate to create the message log.
- Copy config/api_configurations.yml.example to config/api_configurations.yml and fill in your twillio account id and token, the outgoing number you want to use, the name of the Ship you want to get updates for, and notification numbers.
- Run `rake notifier:create_and_send` in the `RACK_ENV=production`
- See all notifications arrive.

Once all initial notifications have been sent the system is somewhat smart about identifying new ones.  When the Rake task is run new notifications will be added to the database and sent.

Todo:
- Isolate numbers into a Model, instead of just a YAML array.
- Create better sent/pending message logging features.
- Provide dockerized Cron system for running in a container. (in progress):w

