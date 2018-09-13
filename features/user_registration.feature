Feature: User registration
  As a guest
  I want to be able to signup
  So that I can subscribe

  Scenario: User signs up
    Given I am on the get started page
    When I select my bottom fit
    And I select my top size
    And I select my waist size
    And I fill in my first name
    And I fill in my last name
    And I fill in my email
    And I fill in my password
    And I click sign up
    Then I should see the subscribe page

  Scenario: User fails to signup
    Given I am on the get started page
    When I click sign up
    Then I should see the get started page
    And I should see error messages
