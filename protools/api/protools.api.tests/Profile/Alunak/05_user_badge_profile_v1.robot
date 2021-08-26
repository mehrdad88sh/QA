*** Settings ***
Documentation              Get User Badge Profile Alunak v1
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Test Cases ***
User Badge Profile Alunak
    Set Log Level          TRACE
    Register To Alunak        v1
    Authentication In Alunak  v1
    Get User Badge            v1

*** Keywords ***
Register To Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                    /${protools_version}/auth/register
    ...                     {"cellphone": "${Random_Number}", "user_type": "real-estate"}
    Integer                 response status        200
    ${response}             output                 response body
    ${token}                Get Value From Json    ${response}                $.token
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
    ${access_token}         Get Value From Json    ${response}                $.access_token
    ${access_token}         Convert To String      ${access_token[0]}
    Set Test Variable       ${access_token}        ${access_token}

Get User Badge
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protools"}
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
