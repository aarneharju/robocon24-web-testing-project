*** Settings ***
Library            Browser
Library            String
Library            Collections

*** Keywords ***
Get available login
    ${login field text}    Get Text                     id=login_credentials
    ${logins}              String.Fetch From Right      ${login field text}    : 
    @{logins}              String.Split String          ${logins}
    ${login}               Set Variable                 ${logins}[0]
    
    RETURN    ${login}

Get available password
    ${password field text}    Get Text                     css=div.login_password
    ${password}               String.Fetch From Right      ${password field text}    \n

    RETURN    ${password}

Login
    [Arguments]    ${username}    ${password}
    Fill Text      id=user-name    txt=${username}
    Fill Secret    id=password     secret=$password
    Click          id=login-button    