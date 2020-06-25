Feature: Since
  In order to get updates since some date
  As a CLI
  I want to get the formatted content

  Scenario: Basic
    When I run `whatsup_github since 'jun 10'`
    Then the output should contain "PR"
    And the output should not contain "MISSING whatsnew in the Technical"

  
  Scenario: With no subcommand or argument
    When I run `whatsup_github`
    Then the output should contain "PR"
    And the file "tmp/whats-new.yml" should exist
    And the file "tmp/whats-new.yml" should contain "type:"
    And the file "tmp/whats-new.yml" should not match /type: ''$/
    And the file "tmp/whats-new.yml" should not contain "MISSING whatsnew in the Technical"
