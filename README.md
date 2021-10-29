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
credentials = {
  "key.production" => ENV["CLICKSIGN_ACCESS_TOKEN_PRODUCTION"]
  "key.sandbox" => ENV["CLICKSIGN_ACCESS_TOKEN_SANDBOX"]
}

Clicksign::API.configure do |config|
  config.credentials = credentials
  config.production = false
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
file = File.open('/path/to/file/local/file.pdf', 'r')
response = Clicksign::API::Document.create( params: { path: '/path/to/file/on/clicksign.pdf', file: file }, token: 'valid_token')
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
=> # key: '123abcd' as example!
```

#### View documents

```ruby
response = Clicksign::API::Document.find(params: { key: '123abcd' }, token: 'valid_token')
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
```

#### Create Signers

```ruby
response = Clicksign::API::Signer.create(params: { email: 'mail@email.com', auths: ['email'], delivery: 'email' }, token: 'valid_token')
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
=> # signer_key: '999poo' as example!
```
#### Add Signers to Document

```ruby

Clicksign::API::DocumentsSigners.create(params: { document_key: '123abcd', signer_key: '999poo', sign_as: 'sign_as' }, token: 'valid_token')
=> #<Faraday::Response ...>

response.success?
=> true # false

JSON.parse(response.body)
=> {:document=> {:key=> '...', :path=> '...', :status => '...', ... }
  ```

##### Creating Documents in Batches

```ruby

batch = Clicksign::API::Batch.create(params: { document_keys: ['123abcd', 'other_document_key'], signer_key: '999poo', summary: true}, token: 'valid_token')
=> #<Faraday::Response ...>

batch.success?
=> true # false

JSON.parse(batch.body)
=> #{"batch"=> {"key"=>"3dd7fa89-15f7-48b6-81e8-7d14a273bbb8"

```
#### Notifying Signer by e-mail

```ruby
request_signature_key = JSON.parse(response_document_above.body)['document']['signers'].first['request_signature_key']
notify = Clicksign::API::Notifier.notify(params: { request_signature_key: request_signature_key }, token: 'valid_token')
=> #<Faraday::Response ...>

notify.success?
=> true # false

JSON.parse(notify.body)
=> ##<struct Faraday::Env, method=:post request_body="{\"request_signature_key\":

```

#### Notifying Signer by whatsapp

```ruby
=> # To deliver this content, its necessary add `phone_number` on Signer

request_signature_key = JSON.parse(response_document_above.body)['document']['signers'].first['request_signature_key']
notify = Clicksign::API::Notifier.notify(params: { request_signature_key: request_signature_key }, token: 'valid_token')
=> #<Faraday::Response ...>

notify.success?
=> true # false

JSON.parse(notify.body)
=> ##<struct Faraday::Env, method=:post request_body="{\"request_signature_key\":


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/clicksign-api.
