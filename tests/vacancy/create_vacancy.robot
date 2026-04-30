*** Settings ***
Documentation     Vacancy Creation Test Suite
...               Tests for creating vacancies on GloPros platform

Library           Browser
Library           Collections

Resource          ../../resources/common/setup_teardown.resource
Resource          ../../resources/pages/login_page.resource
Resource          ../../resources/pages/home_page.resource
Resource          ../../resources/pages/vacancy/create_vacancy_page.resource
Resource          ../../resources/pages/vacancy/vacancy_confirmation_page.resource

# Load variables from YAML config file
Variables         ../../resources/libraries/env_config.py

Suite Setup       Setup Browser    ${HEADLESS}
Suite Teardown    Teardown Browser

*** Test Cases ***
User Can Create A Public Vacancy
    [Documentation]    End-to-end test for creating and publishing a vacancy
    [Tags]             vacancy    e2e    smoke
    # Login
    Given User Navigates To Login Page
    When User Enters Valid Credentials
    And User Submits Login Form
    Then User Should Be Logged In
    # Navigate to vacancy creation
    When User Navigates To Vacancy Creation Page
    Then Vacancy Creation Form Should Be Displayed
    # Fill vacancy form and publish
    When User Fills Experience Section
    And User Fills Education Section
    And User Fills Languages Section
    And User Fills Location Section
    And User Fills Employment Section
    And User Fills Working Hours Section
    And User Fills Description And Publishes
    Then Vacancy Should Be Created Successfully

*** Keywords ***
# LOGIN KEYWORDS
User Navigates To Login Page
    [Documentation]    Navigate to the application login page
    Navigate To Login Page    ${BASE_URL}

User Enters Valid Credentials
    [Documentation]    Enter email and password
    Enter Login Credentials    ${EMAIL}    ${PASSWORD}

User Submits Login Form
    [Documentation]    Submit the login form
    Submit Login Form

User Should Be Logged In
    [Documentation]    Verify successful login
    Verify User Is Logged In

# NAVIGATION KEYWORDS
User Navigates To Vacancy Creation Page
    [Documentation]    Navigate to vacancy creation form
    Navigate To Vacancy Creation    ${VACANCY_CREATE_URL}

Vacancy Creation Form Should Be Displayed
    [Documentation]    Verify vacancy creation page is accessible
    ${url}=    Get Url
    Should Contain    ${url}    /vacancies/create
    Take Screenshot    filename=vacancy_form_loaded

# VACANCY FORM KEYWORDS
User Fills Experience Section
    [Documentation]    Fill job title and skills
    Fill Experience Section    ${JOB_TITLE}    @{SKILLS}

User Fills Education Section
    [Documentation]    Fill education details
    Fill Education Section    ${DEGREE}    ${AREA_OF_STUDY}

User Fills Languages Section
    [Documentation]    Select language
    Fill Languages Section    ${LANGUAGE}

User Fills Location Section
    [Documentation]    Fill location details
    Fill Location Section    ${LOCATION_CITY}    ${LOCATION_TYPE}

User Fills Employment Section
    [Documentation]    Fill employment and contract details
    Fill Employment Section    ${RATE_CLICKS}

User Fills Working Hours Section
    [Documentation]    Fill working hours with ASAP and no end date
    Fill Working Hours Section

User Fills Description And Publishes
    [Documentation]    Fill job description and publish as public
    Fill Description And Publish    ${JOB_DESCRIPTION}

# VERIFICATION KEYWORDS
Vacancy Should Be Created Successfully
    [Documentation]    Verify vacancy was created and redirected
    Verify Vacancy Created Successfully    ${JOB_TITLE}
    Take Screenshot    filename=vacancy_created
