*** Settings ***
Documentation               Get SheypoorPlus Profile v1
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
Get SheypoorPlus Profile
    Set Log Level           TRACE
    Login Protools          v1       car-sale
    Get Profile             v1

*** Keywords ***
Get Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protoolsCars"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile
    Integer                 response status        200
    ${response}             output                 response body
    ${cellphone}            Get Value From Json    ${response}                  $.cellphone
    ${cellphone}            Convert To String      ${cellphone[0]}
    Should Be Equal         ${cellphone}           ${Random_User_Mobile}
    ${files}                Get Value From Json    ${response}                  $.files
    ${files}                Convert To String      ${files[0]}
    Should Be Equal         ${files}               0
    ${advertised}           Get Value From Json    ${response}                  $.advertised
    ${advertised}           Convert To String      ${advertised[0]}
    Should Be Equal         ${advertised}          0
    ${isProfileCompleted}   Get Value From Json    ${response}                  $.isProfileCompleted
    ${isProfileCompleted}   Convert To String      ${isProfileCompleted[0]}
    Should Be Equal         ${isProfileCompleted}  False
