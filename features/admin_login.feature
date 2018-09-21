Feature: Admin login
  As a admin
  I want to be able to login
  So that I can gather user information

  Scenario: Admin logs in
    Given I am a registered admin
    And I am on the login page
    When I fill out the form with my email and password
    And I click login
    Then I should see the admin page

  Scenario: User fails to login
    Given I am on the login page
    When I click login
    Then I should see the login page 
    And I should see a login error 
