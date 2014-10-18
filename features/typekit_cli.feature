@mocked_home_directory
Feature: As a typekit consumer I would like to be able to manage my kits from the CLI

  Background:
    Given I run `bundle exec ruby bin/typekit list_kits` interactively
    And I type "fec094cc45d9d75ac27961d2033eeb38281331b1"
    And I type "y"

  Scenario: Executing the typkit command should list possible options
    Given I run `bundle exec ruby bin/typekit` interactively
    And the output should contain "Commands:"

  Scenario: If I try to show a draft kit that doesn't exist I should see an error message
    Given I run `bundle exec ruby bin/typekit show_draft_kit foo` interactively
    And the output should contain "An error occurred while trying to fetch draft kit, response code 404"

  Scenario: If I try to publish a kit that doesn't exist I should see an error message
    Given I run `bundle exec ruby bin/typekit publish_kit foo` interactively
    And the output should contain "An error occurred while trying to fetch published kit, response code 404"

  Scenario: If I try to show a published kit that doesn't exist I should see an error message
    Given I run `bundle exec ruby bin/typekit show_published_kit foo` interactively
    And the output should contain "An error occurred while trying to fetch published kit, response code 404"

  Scenario: If I try to show the font family for a kit that doesn't exist I should see an error message
    Given I run `bundle exec ruby bin/typekit show_kit_family foo bar` interactively
    And the output should contain "An error occurred while trying to fetch kit family, response code 404"