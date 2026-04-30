*** Settings ***
Documentation    Vacancy confirmation page - verify vacancy was created
Library          Browser

*** Keywords ***
Verify Vacancy Created Successfully
    [Documentation]    Verify redirect to vacancy page after creation
    [Arguments]        ${expected_title}
    # Wait for page title to contain the job title (may take time to load)
    Wait For Condition    Title    contains    ${expected_title}    timeout=60s
