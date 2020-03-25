Feature: Output file

Scenario: Existence
  Then a file named "../whats-new.yml" should exist

Scenario: Check #1
  Then the file "../whats-new.yml" should contain "type:"

Scenario: Check #2
  Then the file "../whats-new.yml" should not match /type: ''$/
