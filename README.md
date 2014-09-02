# On December 8th, 2014, the ESPN API will no longer be active. You can read more about this in their [announcement](http://developer.espn.com/blog/read/publicretirement).

# ESPN

Simply Ruby Wrapper for the ESPN Developer API.

[![Build Status](https://travis-ci.org/andrewpthorp/espn.png)](https://travis-ci.org/andrewpthorp/espn)
[![Gem Version](https://badge.fury.io/rb/espn.png)](http://badge.fury.io/rb/espn)

## Installation

    gem install espn

## Examples

First, setup your client:

    client = ESPN::Client.new(api_key: 'your_api_key_here')

Next, make calls against the ESPN API.

### Sports

The Sports API is what they call a 'Helper' API. This allows you to pull out data for different sections of the API. The Sports API is not documented, but you can see how it works on their [API explorer.](http://developer.espn.com/io-docs)

    client.sports(:mlb)
    # => [#<Hashie::Mash name="baseball"...>]


### Athletes

For more information about the Athletes API, [view the documentation.](http://developer.espn.com/docs/athletes)

    client.athletes(:mlb)
    # => [#<Hashie::Mash fullName="Chase Utley"...>]

    client.athlete(12345, :nfl).fullName
    # => #<Hashie::Mash fullName="LeSean McCoy"...>

### Audio

For more information about the Audio API, [view the documentation.](http://developer.espn.com/docs/audio)

    client.audio(podcast_id: 5)
    # => [#<Hashie::Mash id=8656148 premium=false description=...>]

### ESPN Now

For more information about the ESPN NOW API, [view the documentation.](http://developer.espn.com/docs/now)

    client.now
    # => [#<Hashie::Mash headline="Halladay's future"...>]

### Headlines

For more information about the Headlines API, [view the documentation.](http://developer.espn.com/docs/headlines)

    client.headlines(:mlb)
    # => [#<Hashie::Mash headline="Ronnie Brewer has deal with Rockets"...>]

    client.headline(12345, :nfl)
    # => #<Hashie::Mash headline="Eagles won't be good this year"...>

### Medals

For more information about the Medals API, [view the documentation.](http://developer.espn.com/docs/medals)

    client.medals
    # => #<Hashie::Mash season=#<Hashie::Mash...> sports=[] competitors=[]...>

### Research Notes

For more information about the Resarch Notes API, [view the documentation.](http://developer.espn.com/docs/research)

    client.notes
    # => [#<Hashie::Mash headline="Cowboys Stink"...>]

    client.note(8659824)
    # => #<Hashie::Mash headline="Cowboys Stink"...>

### Scores & Schedules

For more information about the Scores & Schedules API, [view the documentation.](http://developer.espn.com/docs/scores)

    client.scores(:mlb)
    # => [#<Hashie::Mash competitions=[#<Hashie::Mash competitors=[]...]...>]

    client.score(12345)
    # => #<Hashie::Mash competitions=[#<Hashie::Mash competitors=[]...]...>

### Standings

For more information about the Standings API, [view the documentation.](http://developer.espn.com/docs/standings)

    client.standings(:nba)
    # => [#<Hashie::Mash name="Eastern" groups=[]...>]

### Teams

For more information about the Teams API, [view the documentation.](http://developer.espn.com/docs/teams)

    client.teams(:mlb)
    # => [#<Hashie::Mash name="Phillies"...>]

    client.team(12345, :nfl)
    # => #<Hashie::Mash name="Eagles"...>

### Video

For more information about the Video API, [view the documentation.](http://developer.espn.com/docs/video)

    client.videos
    # => [#<Hashie::Mash name="Video Channel" videos=[]...>]

## More Information

This is a Ruby Wrapper around the ESPN developer API. If you want to see how their API works, you can [visit their developer center.](http://developer.espn.com/overview)

## Inspiration

A ton of inspiration was taken from [Octokit][octokit]. Thanks to those guys for
showing the world how API Wrappers should work.

[octokit]: http://github.com/octokit/octokit.rb

## Copyright

Copyright (c) 2013 Andrew Thorp. See [LICENSE][] for details.

[license]: LICENSE.md

## Attribution

[![ESPN API](http://a.espncdn.com/i/apis/attribution/espn-api-red_150.png)](http://espn.go.com)
