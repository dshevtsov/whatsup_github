# WhatsupGithub

[![Build status](https://travis-ci.com/dshevtsov/whatsup_github.svg?branch=master)](https://travis-ci.com/dshevtsov/whatsup_github)
[![Gem version](https://img.shields.io/gem/v/whatsup_github.svg?style=flat)](https://rubygems.org/gems/whatsup_github)

The tool helps to update the [Whats New on DevDocs](http://devdocs.magento.com/whats-new.html).
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

Generate the output with recent updates since April 2 of the current year till today:

```bash
whatsup_github since 'apr 2'
```

By default, it generates recent updates for the passed week:

```bash
whatsup_github
```

You can use different date formats like `'April 2'`, `'2 April'`, `'apr 2'`, `'2 Apr'`, `2018-04-02`.

The result is returned into _tmp/whats-new.yml_ or _tmp/whats-new.md_ files, depending on the format specified in configuration.

## Configuration

The configuration file [`.whatsup.yml`](lib/template/.whatsup.yml) will be created during the first run.

## Authentication

You can use the tool as anonymous user until you'll need to scan private repositories or merely reach the [rate limit of unauthenticted requests](https://developer.github.com/v3/#rate-limiting).
In this case, use [`~/.netrc`](https://github.com/octokit/octokit.rb#using-a-netrc-file) file for authentication.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the Ruby tests, and `bundle exec cucumber features` to run CLI tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dshevtsov/whatsup_github. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Testing

After cloning the repository:

1. Install/verify gems:

```
rake install
```

2. Run tests

```
rake test
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
