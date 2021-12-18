*** Settings ***
Documentation                       Add New Member In SheypoorPlus Shop
Variables                           ../../../../Variables/Variables.py
Resource                            ../../../../Resources/resource.robot
Resource                            ../../../../../../Resources/all.resource

*** Test Cases ***
Add New Member In Alunak Shop
    Set Log Level                   TRACE
    Login Protools Api              v2                     car-sale
    Create Shop In Sheypoor (API)   خودرو
    Add And Validate New Consultant
    Add And Validate New Secretary

*** Keywords ***
Add And Validate New Consultant
    Add New Member                  v2                     consultant
    Validate New Member             v2

Add And Validate New Secretary
    Add New Member                  v2                     secretary
    Validate New Member             v2

Add New Member
    [Arguments]                     ${protools_version}    ${role}
    Clear Expectations
    Set Headers                     {"X-Ticket": "${access_token}"}
    Set Headers                     {"source": "protools"}
    Set Headers                     {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Generate Random Phone Number
    Generate Random username
    Post                             /${protools_version}/team/add
    ...                             {"cellphone": "${Random_User_Mobile}", "role": "${role}", "firstName": "${Random_User_Name}"}
    Integer                         response status        200

Validate New Member
    [Arguments]                     ${protools_version}
    Get                             /${protools_version}/team
    Integer                         response status        200
    ${response}                     output                 response body
    ${cellphone}                    Get Value From Json    ${response}          $.items[0].cellphone
    ${cellphone}                    Convert To String      ${cellphone[0]}
    Should Be Equal                 ${cellphone}           ${Random_User_Mobile}
    ${full_name}                    Get Value From Json    ${response}          $.items[0].full_name
    ${full_name}                    Convert To String      ${full_name[0]}
    Should Be Equal                 ${full_name}           ${Random_User_Name}
