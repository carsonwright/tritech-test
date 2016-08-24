Feature: Organization registers
  Scenario: Get a organization object
    Given I have the correct params and I send them to organizations
     Then I should get an organization back
      And That organization should have an id
      And That organization should have a public key
      And That organization should have a private key