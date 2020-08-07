Feature: Since
  In order to get updates since some date
  As a CLI
  I want to get valid formatted content

  Scenario: Basic
    When I run `whatsup_github since 'jun 10'`
    And the file "tmp/whats-new.yml" should exist
    And the file "tmp/whats-new.yml" should contain "type:"
    And the file "tmp/whats-new.yml" should not match /description:$/
    And the file "tmp/whats-new.yml" should not match /type: ''$/
    And the file "tmp/whats-new.yml" should not contain "MISSING whatsnew in the Technical"
  
  Scenario: With no subcommand or argument
    When I run `whatsup_github`
    Then the output should contain "Searching on"
    Then the output should contain "Done!"
    And the output should not contain "MISSING whatsnew in the Technical"

