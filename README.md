# Whats New on Magento Devdocs

The project helps to update [Whats New on Devdocs](http://devdocs.magento.com/guides/v2.1/magento-devdocs-whatsnew.html).
It filters by labels the PRs merged into repositories and generates an output in a specified format (`markdown` or/and `yaml`).
In the command line, provide the date since when you want to check changes.
By default, the tool filters results for the passed week.

Examples:

Generate the table with recent updates since April 2 till today:

```bash
bin/whats-new-on-devdocs --since 'apr 2'
```

Generate the table with recent updates for the passed week:

```bash
bin/whats-new-on-devdocs
```

You can use different date formats like `'April 2'`, `'2 April'`, `'apr 2'`, `'2 Apr'`, `2018-04-02`.

The result is returned into _output/_.

## Prerequisites

* [Ruby 2](https://www.ruby-lang.org/en/documentation/installation/)
* (Optional). To set up access to internal repositories, add your GitHub token to _credentials.yml_.
* The script uses the GitHub API wrapper [octokit](https://github.com/octokit/octokit.rb):

```bash
gem install octokit
```

## Configuration

Refer to the [configuration file](config.yml.dist).
Copy _config.yml_ from _config.yml.dist_ to specify your configuration.