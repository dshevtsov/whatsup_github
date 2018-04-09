# Whats New on Magento Devdocs

The poject helps to facilitate generation of a table in [Whats New on Devdocs](http://devdocs.magento.com/guides/v2.1/magento-devdocs-whatsnew.html)

It requires a date since when you want to check changes on devdocs. And returns a table to copy it to the original `magento-devdocs-whatsnew.md`.

## Prerequisites

* Set up Ruby 2.x
* `gem install octokit`
* Use "credentials.yml.dist" to create "credentials.yml" and enter your internal github token.

## Configuration

Use "config.yml" to change the base branch (for example when you need to change `develop` to your integration branch.)

## Run

Example of run for collecting updates from April 2 till today:

```bash
bin/whats-new-on-devdocs-from apr 2
```

You can use different different formats for the date: `April 2`, `2 April`, `apr-2`, `2-apr`, `2018-04-02` and so on.

## Result

Check the result in `whats-new-on-devdocs.md`.
You'll see the output of the following format:

|[PR title](First string of PR body)|Versions from issue labels|Type from issue labels|PR merged_at||
