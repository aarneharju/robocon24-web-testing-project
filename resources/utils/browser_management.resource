*** Settings ***
Library            Browser

*** Keywords ***
Set up browser
    [Arguments]    ${browser}=chromium    ${headless}=True    ${slowMo}=0:00:00.5
    ...    ${viewport}={"width": 1920, "height": 1080}    ${url}=https://www.saucedemo.com
    Browser.New Browser    browser=${browser}    headless=${headless}    slowMo=${slowMo}
    ${har_config}=
        ...    BuiltIn.Create Dictionary
        ...    path=${OUTPUT_DIR}${/}har.file
        ...    omitContent=False
    ${vid_config}=
        ...    BuiltIn.Create Dictionary
        ...    dir=${OUTPUT_DIR}
    Browser.New Context    viewport=${viewport}    recordHar=${har_config}    recordVideo=${vid_config}
    Browser.New Page       url=${url}