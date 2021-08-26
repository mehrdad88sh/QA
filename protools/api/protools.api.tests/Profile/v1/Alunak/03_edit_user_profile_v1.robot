*** Settings ***
Documentation               edit user profile alunak v1
Variables                   ../../../Variables/Variables.py
Resource                    ../../../Resources/resource.robot

*** Test Cases ***
Edit User Profile Alunak
    Set Log Level           TRACE
    Login Protools          v2       real-estate
    Edit User Profile       v1

*** Keywords ***
Edit User Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protools"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Generate Username       ${protools_version}
    Post                    /${protools_version}/profile
    ...                     {"full_name": "${Random_User_Name}"}
    Integer                 response status        200
    Get                     /${protools_version}/profile
    Integer                 response status        200
    ${response}             output                 response body
    ${full_name}            Get Value From Json    ${response}          $.full_name
    ${full_name}            Convert To String      ${full_name[0]}
    Should Be Equal         ${full_name}           ${Random_User_Name}
