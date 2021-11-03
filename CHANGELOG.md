# Clicksign::API 1.1.0 (Octuber 29, 2021)

Add support to multiple credentials.
This is useful to work with different accounts and environments, providing flexibility.
For example, applications have different tokens for each environment.
Other useful case, occurs working with multiple companies.

The credentials should be a hash.

Request:
```ruby
file = File.open('/path/to/file/local/file.pdf', 'r')
response = Clicksign::API::Document.create(params: { path: '/path/to/file/on/clicksign.pdf', file: file }, token: 'key.production')
# =>
```
