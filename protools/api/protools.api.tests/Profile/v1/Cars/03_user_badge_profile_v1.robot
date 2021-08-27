*** Settings ***
Documentation               Get User Badge Profile Alunak v1
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
User Badge Profile Alunak
    Set Log Level           TRACE
    Login Protools Api      v1       car-sale
    Get User Badge          v1

*** Keywords ***
Get User Badge
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protoolsCars"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile/user-badge
    Integer                 response status        200
    ${response}             output                 response body
    ${badgeName}            Get Value From Json    ${response}                $[0].badgeName
    ${badgeName}            Convert To String      ${badgeName[0]}
    Should Be Equal         ${badgeName}           سطح شما
    ${isUserBadge}          Get Value From Json    ${response}                $[0].isUserBadge
    ${isUserBadge}          Convert To String      ${isUserBadge[0]}
    Should Be Equal         ${isUserBadge}         True
