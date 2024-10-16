# PuppeteerEntity

PuppeteerEntity is a Ruby gem that provides a simple and intuitive interface for interacting with Puppeteer, a headless Chrome browser. It allows you to take screenshots, capture content, and perform other actions on web pages.

## Installation

To install PuppeteerEntity, add it to your application's Gemfile and run `bundle install`:

```bash
bundle add puppeteer_entity
```

If you're not using Bundler, you can install the gem directly:

```bash
gem install puppeteer_entity
```

## Usage

To use PuppeteerEntity, create a new instance of the `PuppeteerEntity::Screenshot` or `PuppeteerEntity::Content` class, passing the necessary arguments. Then, call the `response` method on the instance to get the HTTP response.

```ruby
args = { url: "https://example.com" }
entity = PuppeteerEntity::Screenshot.new(args)
response = entity.response
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/puppeteer_entity.
