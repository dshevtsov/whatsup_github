# whatsup_github

[![Gem version](https://img.shields.io/gem/v/whatsup_github.svg?style=flat)](https://rubygems.org/gems/whatsup_github)

This tool helps updating data for [Whats New on DevDocs](http://devdocs.magento.com/whats-new.html).
It filters GitHub pull requests and generates a data file.
One pull request sources one data entity.
All filtering parameters are set in a configuration file, except dates.
_Since_ date is set as a CLI argument and the _till_ date is always the moment when the command is run.

## CLI

```console
Commands:
  whatsup_github help [COMMAND]  # Describe available commands or one specific command
  whatsup_github since DATE      # Filters pull requests since the specified date till now. Default: last 7 days.
  whatsup_github version         # Current version of the gem

Usage:
  whatsup_github since DATE

Options:
  [--config=CONFIG]  # Relative path to the configuration file.
                     # Default: .whatsup.yml
```

## What's generated

A resulting YAML file `tmp/whats-new.yml` is generated from GitHub data.

### `description`

Text for `description` is taken from individual pull request's description (same as body).
The text must follow the `whatsnew` keyword and be located at the end.

Example:

```console
This pull request adds ...

Some other details about this pull request.

whatsnew
Added documentation about [New Magento feature](https://devdocs.magento.com/new-magento-feature.html).
```

### `type`

Set as a list of `labels` in `.whatsup.yml`. There are two types of labels in configuration:

- `required` are labels that must include `whatsnew`. Otherwise, resulting output will warn about missing `whatsnew`.
- `optional` are labels that may include `whatsnew`. If `whatsnew` is missing, you won't get any notification about this.

### `versions`

Any GitHub label that starts from a digit followed by a period like in regular expression `\d\.`.
Examples: `2.3.x`, `1.0.3-msi`, `2.x`

### `date`

Date when the pull request was merged.

### `link`

URL of the pull request.

### `contributor`

An author of a pull request.

### `merge_commit`

Merge commit SHA of the pull request.

### `membership`

Membership of the contributor in a configured organization.

### `labels`

All labels added to the pull request.

## Installation

This gem can be installed as a system command-line tool or as a command-line tool available in a project.

### System installation

```bash
gem install whatsup_github
```

### Project installation

Add to your Gemfile:

```ruby
gem 'whatsup_github'
```

And install:

```bash
bundle
```

## Configuration

The default configuration file [`.whatsup.yml`](lib/template/.whatsup.yml) will be created automatically after first run unless it's already there.

To use non-default location or name of the file, use the --config option. Example:

```shell
whatsup_github since 'apr 9' --config 'configs/whatsup_bp.yml'
```

## Authentication

### With the .netrc file

Use [`~/.netrc`](https://github.com/octokit/octokit.rb#using-a-netrc-file) file for authentication.

```config
machine api.github.com
  login <GitHub login>
  password <GitHub token>
```

Example:

```config
machine api.github.com
  login mypubliclogin
  password y9o6YvEoa7IukRWUFdnkpuxNjJ3uwiDQp4zkAdU0
```

Example with GitHub Enterprise:

```config
machine api.github.com
  login mypubliclogin
  password y9o6YvEoa7IukRWUFdnkpuxNjJ3uwiDQp4zkAdU0

machine git.enterprise.example.com
  login myenterpriselogin
  password GtH7yhvEoa7Iuksdo&TFuxNjJ3uwiDQhjbiu8&yhJhG
```

### With an environment variable

Assign the `WHATSUP_GITHUB_ACCESS_TOKEN` to the GitHub token you want to use, prior the `whatsup_github` command.

Example:

```bash
WHATSUP_GITHUB_ACCESS_TOKEN=askk494nmfodic68mk whatsup_github since 'apr 2'
```

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

```bash
bin/setup
```

To install the package:

```bash
rake install
```

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Testing

The project contains [rspec](https://rspec.info/) tests in `spec` and [cucumber](https://app.cucumber.pro/p/af1681aa-415f-44f0-8260-5454a69c472a/aruba/documents/branch/master/features/03_testing_frameworks/cucumber/steps/filesystem/check_existence_of_file.feature) tests in `features`.

#### specs

To run rspec tests:

```bash
rake spec
```

#### features

To run Cucumber tests:

```bash
rake features
```

To pass the `output_file.feature` tests, you need to generate a non-empty `whats-new.yml`.
To test just file:

```bash
bundle exec cucumber features/since.feature
```

NOTE: Cucumber tests will use the configuration file from code `lib/template/.whatsup.yml`.

#### Individual files

Individual files can have tests at the end of a file in a format like:

```ruby
if $PROGRAM_NAME == __FILE__
  # test code here
end
```

To run such test, run the corresponding file:

```bash
ruby lib/whatsup_github/config_reader.rb 
```

The tests use the root `.whatsup.yml` file to read configuration.

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
