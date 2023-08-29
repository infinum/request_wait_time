# RequestQueueTime

RequestQueueTime gem provides middleware which reads request start time on AWS Load balancer from X-Amzn-Trace-Id header,
calculates current request queue time and sends it to AWS Cloud Watch as a custom metric.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add request_queue_time

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install request_queue_time

## Usage

Add request_queue_time.rb to initalizers folder: 
```ruby
RequestQueueTime.setup do |config|
  config.aws_access_key_id = <aws_access_key_id>
  config.aws_secret_access_key = <aws_secret_access_key>
  config.aws_region = <aws_region>
  config.metric_app_name = 'Api' 
  config.metric_environment = ENV['RAILS_ENV']
  config.metric_name = 'request-queue-time'
  config.metric_namespace = 'RequestQueueTime'
end
```

In application.rb set middleware:
   
```ruby
  config.middleware.insert_before 0, RequestQueueTime::Middleware
end

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Running specs:
```ruby
  bundle exec rspec
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/ruby-request_queue_time.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
