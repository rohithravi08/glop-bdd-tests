*** Settings ***
Documentation    Vacancy creation form page - locators and keywords
Library          Browser

*** Variables ***
# EXPERIENCE SECTION
${MAIN_JOB_TITLE_INPUT}           \#main_job_title_input
${SKILLS_INPUT}                   \#skillsInput

# EDUCATION SECTION
${DEGREE_TYPE_DROPDOWN}           \#mui-component-select-education\\.0\\.level
${AREA_OF_STUDY_DROPDOWN}         \#mui-component-select-education\\.0\\.area_education

# LANGUAGES SECTION
${LANGUAGES_DROPDOWN}             [aria-labelledby="selectedLanguages-label"]
${LANGUAGES_APPLY_BUTTON}         div[role="presentation"] > div > ul > div > div > button:nth-child(2)

# LOCATION SECTION
${LOCATION_INPUT}                 [placeholder="Add work location"]
${LOCATION_TYPE_DROPDOWN}         [aria-labelledby="mainLocation.type-label"]
${LOCATION_APPLY_BUTTON}          div[role="presentation"] > div > ul > div > div > button:nth-child(2)

# EMPLOYMENT & CONTRACT SECTION
${EMPLOYMENT_FREELANCE}           xpath=//div[@id="employment"]//span[text()="Freelance"]
${HOURLY_RATE_INCREMENT}          div\#contract svg\#plus-circle-icon

# WORKING HOURS SECTION
${CALENDAR_BUTTON}                div.calendar
${ASAP_CHECKBOX}                  div[role="tooltip"] input[name="isASAP"]
${NO_END_DATE_CHECKBOX}           div[role="tooltip"] input[name="noEndDate"]
${AVAILABILITY_CONFIRM_BUTTON}    [data-testid="required-availability-confirm-button"]

# INTERVIEW SETTINGS SECTION
${DEFAULT_INTERVIEW_SETTINGS}     input[type="radio"][value="default"]

# DESCRIPTION & PUBLISH SECTION
${JOB_DESCRIPTION_EDITOR}         [data-testid="job-description-editor"] .CodeMirror textarea
${PUBLISH_EXPAND_BUTTON}          button\#expand-button
${PUBLISH_PUBLIC_OPTION}          \#expand-button-option-0

*** Keywords ***
# EXPERIENCE SECTION
Fill Job Title
    [Documentation]    Fill the main job title field
    [Arguments]        ${job_title}
    Fill Text          ${MAIN_JOB_TITLE_INPUT}    ${job_title}

Add Skill
    [Documentation]    Add a single skill by typing and selecting from suggestions
    [Arguments]        ${skill}
    Fill Text          ${SKILLS_INPUT}    ${skill}
    # Wait for and click the matching suggestion from the dropdown
    Click              xpath=//div[contains(@class, 'css-1mju4bn')][1]

Add Multiple Skills
    [Documentation]    Add multiple skills from a list
    [Arguments]        @{skills}
    FOR    ${skill}    IN    @{skills}
        Add Skill      ${skill}
    END

Fill Experience Section
    [Documentation]    Fill the complete experience section
    [Arguments]        ${job_title}    @{skills}
    Fill Job Title     ${job_title}
    Add Multiple Skills    @{skills}

# EDUCATION SECTION
Select Degree Type
    [Documentation]    Select degree type from dropdown
    [Arguments]        ${degree}=masters
    Click              ${DEGREE_TYPE_DROPDOWN}
    Click              [data-value="${degree}"]

Select Area Of Study
    [Documentation]    Select area of study from dropdown
    [Arguments]        ${area}=Accounting
    Click              ${AREA_OF_STUDY_DROPDOWN}
    Click              [data-value="${area}"]

Fill Education Section
    [Documentation]    Fill the complete education section
    [Arguments]        ${degree}=masters    ${area}=Accounting
    Select Degree Type    ${degree}
    Select Area Of Study    ${area}

# LANGUAGES SECTION
Select Language
    [Documentation]    Select a language and apply
    [Arguments]        ${language}=English
    Click              ${LANGUAGES_DROPDOWN}
    Click              div[role="presentation"] > div > ul > div[role="option"] > li[value="${language}"]
    Click              ${LANGUAGES_APPLY_BUTTON}

Fill Languages Section
    [Documentation]    Fill the languages section
    [Arguments]        ${language}=English
    Select Language    ${language}

# LOCATION SECTION
Fill Location
    [Documentation]    Fill location and select from suggestions
    [Arguments]        ${location}
    Fill Text          ${LOCATION_INPUT}    ${location}
    # Wait for suggestions and click first matching one
    Click              xpath=//li[contains(text(), '${location}')]

Select Location Type
    [Documentation]    Select location type (remote, onsite, hybrid)
    [Arguments]        ${type}=remote
    Click              ${LOCATION_TYPE_DROPDOWN}
    Click              div[role="presentation"] > div > ul > div[role="option"] > li[value="${type}"]
    Click              ${LOCATION_APPLY_BUTTON}

Fill Location Section
    [Documentation]    Fill the complete location section
    [Arguments]        ${location}    ${type}=remote
    Fill Location      ${location}
    Select Location Type    ${type}

# EMPLOYMENT & CONTRACT SECTION
Select Employment Type Freelance
    [Documentation]    Select Freelance as employment type
    Click              ${EMPLOYMENT_FREELANCE}

Increment Hourly Rate
    [Documentation]    Click the + button to increment hourly rate
    Click              ${HOURLY_RATE_INCREMENT}

Set Hourly Rate
    [Documentation]    Set hourly rate by incrementing to desired value
    [Arguments]        ${clicks}=1
    FOR    ${i}    IN RANGE    ${clicks}
        Increment Hourly Rate
    END

Fill Employment Section
    [Documentation]    Fill employment and contract section
    [Arguments]        ${rate_clicks}=1
    Select Employment Type Freelance
    Set Hourly Rate    ${rate_clicks}

# WORKING HOURS SECTION
Open Working Hours Calendar
    [Documentation]    Open the working hours calendar
    Click              ${CALENDAR_BUTTON}

Select ASAP Start Date
    [Documentation]    Check the ASAP checkbox for start date
    Click              ${ASAP_CHECKBOX}

Select No End Date
    [Documentation]    Check the No end date checkbox
    Click              ${NO_END_DATE_CHECKBOX}

Confirm Working Hours
    [Documentation]    Click confirm button for working hours
    Click              ${AVAILABILITY_CONFIRM_BUTTON}

Fill Working Hours Section
    [Documentation]    Fill working hours with ASAP and no end date
    Open Working Hours Calendar
    Select ASAP Start Date
    Select No End Date
    Confirm Working Hours

# DESCRIPTION & PUBLISH SECTION
Fill Job Description
    [Documentation]    Fill the job description field
    [Arguments]        ${description}
    Fill Text          ${JOB_DESCRIPTION_EDITOR}    ${description}

Select Default Interview Settings
    [Documentation]    Select default interview management settings
    Check Checkbox     ${DEFAULT_INTERVIEW_SETTINGS}

Publish Vacancy As Public
    [Documentation]    Publish vacancy as public
    Click              ${PUBLISH_EXPAND_BUTTON}
    # Select interview settings that appear after clicking expand
    Select Default Interview Settings
    Click              ${PUBLISH_PUBLIC_OPTION}
    # Wait for redirect - URL should change from /vacancies/create to vacancy profile page
    Wait For Condition    Url    not contains    /vacancies/create    timeout=60s
    Wait For Load State    networkidle    timeout=30s

Fill Description And Publish
    [Documentation]    Fill description and publish as public
    [Arguments]        ${description}
    Fill Job Description    ${description}
    Publish Vacancy As Public
