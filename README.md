# WhatsupGithub

[![Build status](https://travis-ci.com/dshevtsov/whatsup_github.svg?branch=master)](https://travis-ci.com/dshevtsov/whatsup_github)
[![Gem version](https://img.shields.io/gem/v/whatsup_github.svg?style=flat)](https://rubygems.org/gems/whatsup_github)

This tool helps to update data for [Whats New on DevDocs](http://devdocs.magento.com/whats-new.html).
It filters GitHub pull requests and generates a data file.
One pull request - one data entity.
All filtering parameters are set in a configuration file, except dates.
_Since_ date is set as a CLI argument and the _till_ date is always the moment when the command is run.

## Prerequisite

The resulting data file is generated from data pulled from GitHub.

### `description`

Pull requests that will appear in search must have text that will fill out the _Description_ cell.
The text must follow the `whatsnew` keyword and be located at the very bottom of a pull request description field.

```
This pull request adds ...

...

whatsnew
Added documentation about [New Magento feature](https://devdocs.magento.com/new-magento-feature.html).
```

### `type`

Set as a list of `labels` in `.whatsup.yml`.

### `versions`

Any GitHub label that starts from a digit followed by a dot (see regex `\d\.`).
Examples: `2.3.x`, `1.0.3-msi`, `2.x`

### `date`

The date when pull request was merged.

## Installation

Same as any other gem.

### Using Bundler as a part of your project

Add to your Gemfile:

```ruby
gem 'whatsup_github'
```

And then execute:

```bash
bundle
```

### Separately

```
gem install whatsup_github
```

## Configuration

The configuration file [`.whatsup.yml`](lib/template/.whatsup.yml) will be created automatically after first run unless it's already there.

## Authentication

Use [`~/.netrc`](https://github.com/octokit/octokit.rb#using-a-netrc-file) file for authentication.

## Usage

```bash
whatsup_github since 'apr 2'
```

If run with no arguments, it generates data for the past week:

```bash
whatsup_github
```

You can use different date formats like `'April 2'`, `'2 April'`, `'apr 2'`, `'2 Apr'`, `2018-04-02`.

## Development

To install dependencies:

```
bin/setup
```

To install the package:

```
rake install
```

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Testing

The project contains [rspec](https://rspec.info/) tests in `spec` and [cucumber](https://app.cucumber.pro/p/af1681aa-415f-44f0-8260-5454a69c472a/aruba/documents/branch/master/features/03_testing_frameworks/cucumber/steps/filesystem/check_existence_of_file.feature) tests in `features`.

#### specs

To run rspec tests:

```
rake spec
```

#### features

To run cucumber tests:

```
rake features
```

To pass the `output_file.feature` tests, you need to generate a non-empty `whats-new.yml`.
To test just file:

```
bundle exec cucumber features/output_file.feature
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dshevtsov/whatsup_github. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
