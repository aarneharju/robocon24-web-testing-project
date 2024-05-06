*** Settings ***
Library            Browser
Library            String
Library            Collections

*** Test Cases ***
Test 1
    Browser.New Browser    browser=chromium    headless=False    slowMo=0:00:01
    Browser.New Context    viewport={"width": 1920, "height": 1080}
    Browser.New Page       url=https://www.saucedemo.com

    ${logins}       Browser.Get Text             selector=id=login_credentials
    ${password}     Browser.Get Text             selector=div.login_password
    Log Many        ${logins}    ${password}
    ${logins}       String.Fetch From Right      ${logins}    : 
    @{logins}       String.Split String          ${logins}
    Log Many        @{logins}
    ${login}        Collections.Get From List    ${logins}    0
    ${password}     String.Fetch From Right      ${password}    \n
    Fill Text       selector=id=user-name        txt=${login}
    Fill Secret     selector=id=password         secret=$password
    Click           selector=id=login-button
    Click           id=add-to-cart-sauce-labs-onesie
    Click           id=add-to-cart-sauce-labs-bike-light
    Click           id=add-to-cart-sauce-labs-backpack
    Click           id=shopping_cart_container
    Click           id=checkout
    Fill Text       id=first-name                Rob
    Fill Text       id=last-name                 Ocon
    Fill Text       id=postal-code               03-2024
    Click           id=continue
    Click           id=finish
    Click           id=react-burger-menu-btn
    Click           id=logout_sidebar_link
    Close Browser