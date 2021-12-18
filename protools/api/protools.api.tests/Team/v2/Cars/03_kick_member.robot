*** Settings ***
Documentation                       Remove Member From SheypoorPlus Shop
Variables                           ../../../../Variables/Variables.py
Resource                            ../../../../Resources/resource.robot
Resource                            ../../../../../../Resources/all.resource

*** Test Cases ***
Add New Member In Alunak Shop
    Set Log Level                   TRACE
    Login Protools Api              v2                     car-sale
    Create Shop In Sheypoor (API)   خودرو
    Remove Consultant Member        v2
    Remove Secretary Member         v2

*** Keywords ***
Remove Consultant Member
    [Arguments]                     ${protools_version}
    Clear Expectations
    Set Headers                     {"X-Ticket": "${access_token}"}
    Set Headers                     {"source": "protoolsCars"}
    Set Headers                     {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                             /${protools_version}/team
    Integer                         response status        200
    ${response}                     output                 response body
    ${cellphone}                    Get Value From Json    ${response}          $.items[0].cellphone
    ${cellphone}                    Convert To String      ${cellphone[0]}
    ${full_name}                    Get Value From Json    ${response}          $.items[0].full_name
    ${full_name}                    Convert To String      ${full_name[0]}
    Post                             /${protools_version}/team/kick
    ...                             {"cellphone": "${cellphone}", "firstName": "${full_name}"}
    Integer                         response status        200
    ${response}                     output                 response body
    Should Not Contain              ${response}            ${full_name}

Remove Secretary Member
    [Arguments]                     ${protools_version}
    Clear Expectations
    Set Headers                     {"X-Ticket": "${access_token}"}
    Set Headers                     {"source": "protoolsCars"}
    Set Headers                     {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                             /${protools_version}/team
    Integer                         response status        200
    ${response}                     output                 response body
    ${cellphone}                    Get Value From Json    ${response}          $.items[0].cellphone
    ${cellphone}                    Convert To String      ${cellphone[0]}
    ${full_name}                    Get Value From Json    ${response}          $.items[0].full_name
    ${full_name}                    Convert To String      ${full_name[0]}
    Post                             /${protools_version}/team/kick
    ...                             {"cellphone": "${cellphone}", "firstName": "${full_name}"}
    Integer                         response status        200
    ${response}                     output                 response body
    Should Not Contain              ${response}            ${full_name}
