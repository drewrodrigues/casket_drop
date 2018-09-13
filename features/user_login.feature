Feature: User login
  As a user
  I want to be able to login
  So that I can view my account information

  Scenario: User logs in
    Given I am a registered user
    And I am on the login page
    When I fill out the form with my email and password
    And I click login
    Then I should see the dashboard page

  Scenario: User fails to login
    Given I am on the login page
    When I click login
    Then I should see the login page 
    And I should see a login error 


