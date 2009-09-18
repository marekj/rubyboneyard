Feature: Google Search
  In order to find more about Watir
  as a google user
  I want to search for watir

  Scenario Outline: Google Search for Watir
    Given that we are on the Google Homepage
    When I search for <term>
    Then I should see link <link_for_term>

    Examples:
    | term  | link_for_term     |
    | watir     | Watir - Overview  |
    | watirloo  | Semantic Page Objects Modeling   |
    | taza framework    | Home - taza - Github |
    | watircraft |  WatirCraft Framework  |


