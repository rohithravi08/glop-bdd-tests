*** Settings ***
Documentation    Home page keywords after successful login
Library          Browser

*** Keywords ***
Navigate To Vacancy Creation
    [Documentation]    Navigate to vacancy creation page
    [Arguments]    ${vacancy_create_url}
    Go To    ${vacancy_create_url}
    Wait For Load State    networkidle
    # Wait for the form to be fully rendered
    Wait For Elements State    id=main_job_title_input    visible    timeout=30s
