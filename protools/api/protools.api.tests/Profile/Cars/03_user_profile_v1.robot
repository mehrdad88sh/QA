*** Settings ***
Documentation              Get SheypoorPlus Profile v1
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Test Cases ***
Get Alunak Profile
    Set Log Level          TRACE
    Register To Alunak        v1
    Authentication In Alunak  v1
    Get Profile               v1

*** Keywords ***
Register To Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                    /${protools_version}/auth/register
    ...                     {"cellphone": "${Random_Number}", "user_type": "car-sale"}
    Integer                 response status        200
    ${response}             output                 response body
    ${token}                Get Value From Json    ${response}           $.token
    ${token}                Convert To String      ${token[0]}
    Set Test Variable       ${token}               ${token}

Authentication In Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/authenticate-by-password.json
    Post                    /${protools_version}/auth/authorize
    ...                     {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                 response status        200
    ${response}             output                 response body
    ${access_token}         Get Value From Json    ${response}           $.access_token
    ${access_token}         Convert To String      ${access_token[0]}
    Set Test Variable       ${access_token}        ${access_token}

Get Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protoolsCars"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile
    Integer                 response status        200
    ${response}             output                 response body
    ${cellphone}            Get Value From Json    ${response}           $.cellphone
    ${cellphone}            Convert To String      ${cellphone[0]}
    Should Be Equal         ${cellphone}           ${Random_Number}
    ${files}                Get Value From Json    ${response}                $.files
    ${files}                Convert To String      ${files[0]}
    Should Be Equal         ${files}               0
    ${advertised}           Get Value From Json    ${response}                $.advertised
    ${advertised}           Convert To String      ${advertised[0]}
    Should Be Equal         ${advertised}          0
    ${isProfileCompleted}   Get Value From Json    ${response}                $.isProfileCompleted
    ${isProfileCompleted}   Convert To String      ${isProfileCompleted[0]}
    Should Be Equal         ${isProfileCompleted}  False
