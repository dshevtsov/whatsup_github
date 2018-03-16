# WhatsUpDevdocs

The poject helps to facilitate generation of a table in [Whats New on Devdocs](http://devdocs.magento.com/guides/v2.1/magento-devdocs-whatsnew.html)

It requires a date since when you want to check changes on devdocs. And returns a table to copy it to the original `magento-devdocs-whatsnew.md`.

## Prerequisites

* Set up Ruby 2.x
* `gem install octokit`
* Use "credentials.yml.dist" to create "credentials.yml" and enter your internal github token.

## Configuration

Use "config.yml" to change the base branch (for example when you need to change `develop` to your integration branch.)

## Run

Example of run:

```bash
ruby -I lib bin/whats-new-on-devdocs-from 5-feb-2018
```

## Result

Check the result in `whats-new-on-devdocs.md`.

Currently the table shows the following fromat:

|[PR title](First string of PR body)|Versions from issue labels|Type from issue labels|PR merged_at||
