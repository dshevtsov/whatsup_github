# Changelog

## 0.4.0

### General

- Loading more data about pull requests via API
- Loading data about configured organization members via API
- Upgraded gem specs

### New configuration option

Added `membership` to configuration. Value: name of an organization to check membership of a contributor.

### New output data

Added `merge_commit`, `labels`, and `membership` to YAML output.
Values for `membership`:
    - `true` if contributor is a member of the configured organization
    - `false` if not a member
    - empty if not configured

## 0.3.1

- Added `contributor` and `profile` output data.

## 0.3.0

- Added "magic word" to configuration file
- Added the requested GitHub query to terminal output (#13)
- Fixed the issue with empty description (#21)

## 0.2.0

- Implemented two types of labels in configuration: 'optional' and 'required'.

## 0.0.1

The tool is released as a gem.
