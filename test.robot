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
    # ${login}        Collections.Get From List    ${logins}    0
    VAR    ${login}    ${logins}[0]    scope=SUITE
    ${password}     String.Fetch From Right      ${password}    \n
    VAR    ${password}    ${password}    scope=SUITE
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

Sauce Labs test 2
    Browser.New Browser          chromium    False    slowMo=0:00:00.5
    Browser.New Context          viewport={"width": 1366, "height": 768}
    Browser.New Page             url=https://www.saucedemo.com/
    Browser.Fill Text            xpath=//input[@name='user-name' and @id='user-name']    ${login}
    Browser.Fill Secret          id=password    $password
    Browser.Click                input#login-button
    ${current sorting order}=    Browser.Get Text    css=span.active_option
    BuiltIn.Log                  Current sorting is ${current sorting order}
    @{item elements}=            Browser.Get Elements    xpath=//div[contains(@class,"inventory_item_name")]
    @{items}=                    BuiltIn.Create List

    FOR    ${element}    IN    @{item elements}
        ${item name}=    Browser.Get Text    ${element}
        ${item name}=    String.Convert To Lower Case    ${item name}
        Collections.Append To List    ${items}    ${item name}
    END
    
    ${actual order items}=       Collections.Copy List    ${items}
    Collections.Sort List        ${items}
    BuiltIn.Should Be Equal      ${items}    ${actual order items}