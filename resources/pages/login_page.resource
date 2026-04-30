*** Settings ***
Documentation    Login page locators and keywords
Library          Browser

*** Variables ***
# Home page login button
${HOME_LOGIN_BUTTON}           button:has-text("Login")
# Auth0 login page locators
${LOGIN_EMAIL_INPUT}           input#username
${LOGIN_PASSWORD_INPUT}        input#password
${LOGIN_SUBMIT_BUTTON}         button[data-action-button-primary="true"]

*** Keywords ***
Navigate To Login Page
    [Documentation]    Navigate to the login page, fail immediately on 502/503 errors
    [Arguments]        ${base_url}
    New Page
    ${promise}=        Promise To    Wait For Response    ${base_url}
    Go To              ${base_url}
    ${response}=       Wait For    ${promise}
    ${status}=         Get From Dictionary    ${response}    status
    IF    ${status} == 502
        Take Screenshot    filename=error_502_bad_gateway
        Fail    Server returned 502 Bad Gateway. Site may be down.
    END
    IF    ${status} == 503
        Take Screenshot    filename=error_503_service_unavailable
        Fail    Server returned 503 Service Unavailable. Site may be down.
    END
    Wait For Load State    networkidle
    # Click Login button on home page to access login form
    Click              ${HOME_LOGIN_BUTTON}
    Wait For Load State    networkidle

Enter Login Credentials
    [Documentation]    Fill in email and password fields
    [Arguments]        ${email}    ${password}
    Fill Text          ${LOGIN_EMAIL_INPUT}    ${email}
    Fill Text          ${LOGIN_PASSWORD_INPUT}    ${password}

Submit Login Form
    [Documentation]    Click login button and wait for navigation
    Click              ${LOGIN_SUBMIT_BUTTON}
    Wait For Load State    networkidle

Verify User Is Logged In
    [Documentation]    Verify login was successful by checking URL
    Wait For Load State    networkidle
    ${url}=            Get Url
    Should Not Contain    ${url}    login
