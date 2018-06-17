# Whats New on Magento Devdocs

The project facilitates updating [Whats New on Devdocs](http://devdocs.magento.com/guides/v2.1/magento-devdocs-whatsnew.html)

It requires the date since when you want to check changes on devdocs. And returns the table in format of the original `magento-devdocs-whatsnew.md`.

## Prerequisites

* Set up Ruby 2.x
* Create _credentials.yml_ from _credentials.yml.dist_. Add your credentials to have access to the internal repo.

```bash
gem install octokit
```

## Configuration

Use _config.yml_ to change the base branch. The default is `develop`.

## Run

Example of collecting recent updates starting from April 2:

```bash
bin/whats-new-on-devdocs-from apr 2
```

`April 2`, `2 April`, `apr-2`, `2-apr`, `2018-04-02` also work.

## Return

The result goes into `/whats-new-on-devdocs.md`.
