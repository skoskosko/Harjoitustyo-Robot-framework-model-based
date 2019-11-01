*** Settings ***
Suite Setup     Open Browser  ${LOGIN_PAGE_URL}   googlechrome
Suite Teardown  Close Browser
Test Setup      Go to  ${LOGIN_PAGE_URL}
Library         SeleniumLibrary

*** Variables ***
${USERNAME_FIELD}  input-username
${PASSWORD_FIELD}  input-password
${LOGIN_BUTTON}    album-login
${VALID_USERNAME}  user
${VALID_PASSWORD}  password
${LOGIN_PAGE_URL}  http://localhost:8080/ps/v1/index.html

*** Machine ***
${USERNAME}  any of  ${VALID_USERNAME}  ${VALID_PASSWORD}  invalid123  ${EMPTY}
${PASSWORD}  any of  ${VALID_PASSWORD}  ${VALID_USERNAME}  password123  ${EMPTY}

# Add an equivalence rule to reduce the number of generated tests
${USERNAME} == ${VALID_PASSWORD}  <==>  ${PASSWORD} == ${VALID_USERNAME}

Login Page
  Title Should Be  Login Page
  [Actions]
    Submit Credentials  ==>  Welcome Page  when  ${USERNAME} == ${VALID_USERNAME}  and  ${PASSWORD} == ${VALID_PASSWORD}
    Submit Credentials  ==>  Error Page    otherwise

Welcome Page
  Title Should Be  Welcome Page

Error Page
  Title Should Be  Error Page

*** Keywords ***
Submit Credentials
  Input Text      ${USERNAME_FIELD}  ${USERNAME}
  Input Password  ${PASSWORD_FIELD}  ${PASSWORD}
  Click Button    ${LOGIN_BUTTON}