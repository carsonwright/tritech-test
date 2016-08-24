Feature: Users
  Scenario: Register user
    Given I have the correct params and I send them to organizations
      And I should get an organization back
      And I have the correct params and I send them to users
     Then I should have a user object
      And That user object should have a first name
      And That user object should have a last name
      And That user object should have an email
  Scenario: List user
    Given I have the correct params and I send them to organizations
      And I should get an organization back
      And I add 2 users
      And I request my users
     Then I should get back a list of users