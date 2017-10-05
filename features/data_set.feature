Feature: Data Set Functionality

  Scenario: Requesting data from the default data location
    Given the default configuration file in the default location
    When asking for the value for "base_url"
    Then the value should be "http://testerstories.com"

  Scenario: Requesting data that exists from specified data location
    Given the test data configuration file
    When asking for the value for "base_url"
    Then the value should be "http://testerstories.com"

  Scenario: Requesting data that does not exist
    Given the test data configuration file
    When asking for the non-existent value for "not_there"
    Then a NoMethodError exception is raised

  Scenario: Requesting data that is broken into elements of data
    Given the test data configuration file
    When asking for the value for "login"
    Then data set recognizes a data element
    And the "username" value for the element should be "tester"
    And the "password" value for the element should be "testing"

  Scenario: Requesting data from nested data elements
    Given the test data configuration file
    When asking for the value for "stardate"
    And asking for the element value for "contexts"
    Then the "tos" value for the element should be "the original series"
    And the "tng" value for the element should be "the next generation"

  Scenario: Converting element data to a hash
    Given the test data configuration file
    When asking for the value for "login"
    Then data set recognizes a data element
    And the hash of values will be:
      | username | tester  |
      | password | testing |

  Scenario: Requesting data that is numerical
    Given the test data configuration file
    When asking for the value for "port"
    Then the value should be 9292

  Scenario: Requesting data that is decimal
    Given the test data configuration file
    When asking for the value for "euler_number"
    Then the value should be 2.718

  Scenario: Requesting data that is boolean
    Given the test data configuration file
    When asking for the value for "truthhood"
    Then the value should be true

    When asking for the value for "falsehood"
    Then the value should be false

  Scenario: Requesting data that is a symbol
  Given the test data configuration file
  When asking for the value for "symbolic"
  Then the value should be :symbol

  Scenario: Requesting data that is an array of values
    Given the test data configuration file
    When asking for the value for "invalid_conditions"
    Then values of the array are "only letters", "some letters", "less than four numbers"

  Scenario: Getting the default filename from an environment variable
    Given an environment variable named "DATA_SET_FILE" set to "test_sample.yml"
    When asking for the value for "from_the_env"
    Then the value should be "read from the env"

  Scenario: Requesting non-existent data that has a default value provided
    Given the test data configuration file
    When asking for the non-existent value for "not_there" with default value "here"
    Then the value should be "here"

  Scenario: Requesting non-existent data that has a default block provided
    Given the test data configuration file
    When asking for the non-existent value for "not_there" with default block returning "here"
    Then the value should be "here"

  Scenario: Requesting non-existent data that has a default block provided
    Given the test data configuration file
    When asking for the non-existent value for "not_there" with default lambda returning "here"
    Then the value should be "here"
    And the lambda should be passed the property "not_there"

  Scenario: Requesting non-existent data that has a default proc provided
    Given the test data configuration file
    When asking for the non-existent value for "not_there" with default proc returning "here"
    Then the value should be "here"
