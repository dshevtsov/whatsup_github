# Whats New on Magento Devdocs

The project helps to update [Whats New on Devdocs](http://devdocs.magento.com/guides/v2.1/magento-devdocs-whatsnew.html).
It filters the PRs merged into [magento/devdocs](https://github.com/magento/devdocs) by labels and generates a table in the ready-to-paste format.
You only need to provide the date since when you want to check changes on devdocs.
By default, --since means the date week ago.

Examples:

Generate the table with recent updates since April 2 till today:

```bash
bin/whats-new-on-devdocs --since 'apr 2'
```

Generate the table with recent updates for the past week:

```bash
bin/whats-new-on-devdocs
```

You can use different date formats like `'April 2'`, `'2 April'`, `'apr 2'`, `'2 Apr'`, `2018-04-02`.

The result is returned into `/whats-new-on-devdocs.md`.

## Prerequisites

* [Ruby 2](https://www.ruby-lang.org/en/documentation/installation/)
* (Optional). To set up access to internal repositories, create _credentials.yml_ from _credentials.yml.dist_.
* The script uses the GitHub API wrapper [octokit](https://github.com/octokit/octokit.rb):

```bash
gem install octokit
```

## Configuration

You can change the base branch in _config.yml_.
The default is `master`.