# WhatsupGithub

The project helps to update the [Whats New on DevDocs](http://devdocs.magento.com/guides/v2.3/whats-new.html).
It filters by labels the pull requests merged into repositories and generates an output in a specified format (`markdown` or/and `yaml`).
In the command line, provide the date since when you want to check changes.
By default, the tool filters results for the passed week.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'whatsup_github'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install whatsup_github
```

## Usage

Generate the table with recent updates since April 2 till today:

```bash
bin/whatsup_github since 'apr 2'
```

Generate the table with recent updates for the passed week:

```bash
bin/whatsup_github
```

You can use different date formats like `'April 2'`, `'2 April'`, `'apr 2'`, `'2 Apr'`, `2018-04-02`.

The result is returned into _output/_.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dshevtsov/whatsup_github. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WhatsupGithub project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dshevtsov/whatsup_github/blob/master/CODE_OF_CONDUCT.md).
