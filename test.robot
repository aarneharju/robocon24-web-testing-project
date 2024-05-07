*** Settings ***
Library            Browser
Library            String
Library            Collections
Resource           utils/browser_management.resource
Resource           pages/login_page.resource
Test Setup         browser_management.Set up browser    headless=False

*** Test Cases ***
Test 1

    ${login}              login_page.Get available login
    ${password}           login_page.Get available password
    VAR    ${login}       ${login}       scope=SUITE
    VAR    ${password}    ${password}    scope=SUITE
    login_page.Login      username=${login}    password=${password}
    Click                 id=add-to-cart-sauce-labs-onesie
    Click                 id=add-to-cart-sauce-labs-bike-light
    Click                 id=add-to-cart-sauce-labs-backpack
    Click                 id=shopping_cart_container
    Click                 id=checkout
    Fill Text             id=first-name                Rob
    Fill Text             id=last-name                 Ocon
    Fill Text             id=postal-code               03-2024
    Click                 id=continue
    Click                 id=finish
    Click                 id=react-burger-menu-btn
    Click                 id=logout_sidebar_link
    Close Browser

Sauce Labs test 2
    
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