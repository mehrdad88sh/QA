*** Settings ***
Documentation                       Get Team Members In SheypoorPlus v2
Variables                           ../../../../Variables/Variables.py
Resource                            ../../../../Resources/resource.robot
Resource                            ../../../../../../Resources/all.resource

*** Test Cases ***
Get Team Members In Alunak
    Set Log Level                   TRACE
    Login Protools Api              v2                     car-sale
    Create Shop In Sheypoor (API)   خودرو
    Get Team Members                v2

*** Keywords ***
Get Team Members
    [Arguments]                     ${protools_version}
    Clear Expectations
    Set Headers                     {"X-Ticket": "${access_token}"}
    Set Headers                     {"source": "protoolsCars"}
    Set Headers                     {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                             /${protools_version}/team
    Integer                         response status        200
    ${response}                     output                 response body

Validate Consultant
    ${full_name}                    Get Value From Json    ${response}          $.items[0].full_name
    ${full_name}                    Convert To String      ${full_name[0]}
    Should Be Equal                 ${full_name}           ${ConsultantNames}
    ${Role}                         Get Value From Json    ${response}          $.items[0].role
    ${Role}                         Convert To String      ${Role[0]}
    Should Be Equal                 ${Role}                مشاور
    ${role_slug}                    Get Value From Json    ${response}          $.items[0].role_slug
    ${role_slug}                    Convert To String      ${role_slug[0]}
    Should Be Equal                 ${role_slug}           consultant

Validate Secretary
    ${full_name}                    Get Value From Json    ${response}          $.items[1].full_name
    ${full_name}                    Convert To String      ${full_name[0]}
    Should Be Equal                 ${full_name}           ${ConsultantNames}
    ${Role}                         Get Value From Json    ${response}          $.items[1].role
    ${Role}                         Convert To String      ${Role[0]}
    Should Be Equal                 ${Role}                منشی
    ${role_slug}                    Get Value From Json    ${response}          $.items[1].role_slug
    ${role_slug}                    Convert To String      ${role_slug[0]}
    Should Be Equal                 ${role_slug}           secretary
