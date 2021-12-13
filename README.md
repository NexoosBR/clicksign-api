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
document = Clicksign::API::Document.create( params: { path: '/path/to/file/on/clicksign.pdf', file: file }, token: "key.sandbox")
# => {"document"=> {"key"=>"00000000-0000-0000-0000-000000000000"}

```

#### View documents

```ruby
find_document = Clicksign::API::Document.find(params: { key: response_document['document']['key'] }, token: "key.sandbox")
# => {"document"=> {"key"=>"00000000-0000-0000-0000-000000000000"}

```

#### Create Signers

```ruby
signer = Clicksign::API::Signer.create(params: { email: 'mail@email.com', auths: ['email'], delivery: 'email' }, token: "key.sandbox")
# => {"signer"=> {"key"=>"00000000-0000-0000-0000-000000000000"}

```
#### Add Signers to Document

```ruby
signer_document = Clicksign::API::DocumentsSigners.create(params: { document_key: response_document['document']['key'], signer_key: response_signer['key'], sign_as: 'sign_as' }, token: "key.sandbox")
# => {"list"=>{"key"=>"00000000-0000-0000-0000-000000000000"}

  ```

##### Creating Documents in Batches

```ruby
batch = Clicksign::API::Batch.create(
  params: {
    document_keys: [response_document['document']['key'], 'other_document_key'],
    signer_key: response_signer['key'],
    summary: true
  },
  token: "key.sandbox"
)

# => {"batch"=>{"key"=>"00000000-0000-0000-0000-000000000000"}

```
#### Notifying Signer by e-mail

```ruby
notify = Clicksign::API::Notifier.notify(params: { request_signature_key: 'request_signature_key' }, token: "key.sandbox")
# => {:status=>202} 

```

#### Notifying Signer by whatsapp

```ruby
notify = Clicksign::API::Notifier.notify(params: { request_signature_key: 'request_signature_key' }, token: "key.sandbox")
# => {:status=>202} 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/clicksign-api.
