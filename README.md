# ESPN

Simply Ruby Wrapper for the ESPN Developer API.

[![Build Status](https://travis-ci.org/andrewpthorp/espn.png)](https://travis-ci.org/andrewpthorp/espn)

## Installation

    gem install espn

## Examples

First, setup your client:

    client = ESPN::Client.new(api_key: 'your_api_key_here')

Next, make calls against the ESPN API.

### Sports

    sport = client.sports(sport: 'baseball', league: 'mlb').sports.first
    puts sport.leagues.first.groups.first.name
    # => American League

### Headlines

    headline = client.headlines(sport: 'baseball', league: 'mlb').headlines.first
    puts headline.title
    # => Atlanta Braves outfielder Jason Heyward hit in jaw with pitch

## Inspiration

A ton of inspiration was taken from [Octokit][octokit]. Thanks to those guys for
showing the world how API Wrappers should work.

[octokit]: http://github.com/octokit/octokit.rb

## Copyright

Copyright (c) 2013 Andrew Thorp. See [LICENSE][] for details.

[license]: LICENSE.md

## Attribution

[![ESPN API](http://a.espncdn.com/i/apis/attribution/espn-api-red_150.png)](http://espn.go.com)
