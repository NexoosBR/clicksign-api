# Clicksign::Api

[![Gem Version](https://badge.fury.io/rb/clicksign-api.svg)](https://badge.fury.io/rb/clicksign-api)
[![Build Status](https://travis-ci.org/NexoosBR/clicksign-api.svg?branch=master)](https://travis-ci.org/NexoosBR/clicksign-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/7e4c11dd4129d37ee34c/maintainability)](https://codeclimate.com/github/NexoosBR/clicksign-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/7e4c11dd4129d37ee34c/test_coverage)](https://codeclimate.com/github/NexoosBR/clicksign-api/test_coverage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clicksign-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clicksign-api

## Setup:

By default, all requests use Clicksign's SANDBOX.

```ruby
Clicksign::API.configure do |config|
  config.access_token = ENV['CLICKSIGN_ACCESS_TOKEN']
end
```

To use PRODUCTION environment, you have to setup:

```ruby
Clicksign::API.configure do |config|
  config.access_token = ENV['CLICKSIGN_ACCESS_TOKEN']
  config.production = true
end
```

## Usage:

To see all available parameters, please, check the [API docs](https://developers.clicksign.com/docs/informacoes-gerais).

#### Create documents

```ruby
response = Clicksign::API::Document.create(path: '/path/to/file.pdf', file: file)
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
```

#### View documents

```ruby
response = Clicksign::API::Document.find('DOCUMENT_KEY')
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
```

#### Add signers

```ruby
response = Clicksign::API::Signer.create('DOCUMENT_KEY', signer)
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/clicksign-api.
