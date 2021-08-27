*** Settings ***
Documentation                     Upgrade To Premium User In Alunak v2
Variables                         ../../../../Variables/Variables.py
Resource                          ../../../../Resources/resource.robot
Library                           SeleniumLibrary

*** Test Cases ***
Upgrade User To Premium Profile
    Set Log Level                 TRACE
    Login Protools                v2                                  real-estate
    Upgrade To Premium Profile    v2
    Validate Premium User Profile  v2

*** Keywords ***
Upgrade To Premium Profile
    [Arguments]                   ${protools_version}
    Clear Expectations
    Set Headers                   {"X-Ticket": "${access_token}"}
    Set Headers                   {"source": "protools"}
    Set Headers                   {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                          /${protools_version}/profile/upgrade
    Integer                       response status                     200
    ${response}                   output                              response body
    ${Payment_URL}                Get Value From Json                 ${response}         $.url
    ${Payment_URL}                Convert To String                   ${Payment_URL[0]}
    Set Test Variable             ${Payment_URL}                      ${Payment_URL}
    Check Payment In Sheypoor     پروفایل حرفه‌ای

Validate Premium User Profile
    [Arguments]                   ${protools_version}
    Get                           /${protools_version}/profile/details
    Integer                       response status                     200
    ${response}                   output                              response body
    ${isPremium}                  Get Value From Json                 ${response}         $.isPremium
    ${isPremium}                  Convert To String                   ${isPremium[0]}
    Should Be Equal               ${isPremium}                        True

Check Payment In Sheypoor
    [Arguments]                   ${Package_Type}
    Open Browser                  ${Payment_URL}                      browser=chrome
    Wait Until Page Contains      درحال انتقال به درگاه پرداخت        timeout=10s
    Click Element                 css:button.button.green
    Wait Until Page Contains      پرداخت شما با موفقیت انجام شد.      timeout=10s
    Element Should Contain        class:text-right                    ${Package_Type}
    Close Browser
