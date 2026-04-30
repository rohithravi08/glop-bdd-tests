*** Settings ***
Documentation    Common setup and teardown keywords for browser automation
Library          Browser

*** Keywords ***
Setup Browser
    [Documentation]    Initialize browser with Chromium and set viewport
    [Arguments]        ${headless}=${False}
    New Browser    chromium    headless=${headless}
    New Context    viewport={'width': 1920, 'height': 1080}

Teardown Browser
    [Documentation]    Close all browser instances
    Close Browser    ALL
