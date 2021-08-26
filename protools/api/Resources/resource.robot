*** Settings ***
Documentation                 Api resources
Library                       REST                     ${staging}/api/protools
Library                       JSONLibrary
Library                       String
Library                       FakerLibrary             locale=fa_IR

*** Keywords ***
Login Alunak
    [Arguments]               ${protools_version}
    Register To Alunak        ${protools_version}
    Authentication In Alunak  ${protools_version}

Register To Alunak
    [Arguments]               ${protools_version}
    Expect Request	          {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers               {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response           ${CURDIR}/../protools.api.tests/Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                      /${protools_version}/auth/register
    ...                       {"cellphone": "${Random_Number}", "user_type": "real-estate"}
    Integer                   response status          200
    ${response}               output                   response body
    ${token}                  Get Value From Json      ${response}              $.token
    ${token}                  Convert To String        ${token[0]}
    Set Test Variable         ${token}                 ${token}

Authentication In Alunak
    [Arguments]               ${protools_version}
    Expect Request	          {"body": {"required": ["username", "password"]}}
    Set Headers               {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server
    Expect Response           ${CURDIR}/../protools.api.tests/Authentication/Versions/${protools_version}/schema/authenticate-by-password.json
    Post                      /${protools_version}/auth/authorize
    ...                       {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                   response status          200
    ${response}               output                   response body
    ${access_token}           Get Value From Json      ${response}              $.access_token
    ${access_token}           Convert To String        ${access_token[0]}
    Set Test Variable         ${access_token}          ${access_token}

Generate Random Phone Number
    ${Random_Number}          Generate Random String   7   [NUMBERS]
    Set Suite Variable        ${Random_Number}         0900${Random_Number}

Get Code From Mock Server
    Clear Expectations
    Get                       ${stagingMock}=${Random_Number}
    ...                       headers={"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Integer                   response status          200
    ${response}               output                   response body
    ${Code}                   Get Value From Json      ${response}              $.code
    ${Code}                   Convert To String        ${Code[0]}
    Set Suite Variable        ${Code}                  ${Code}

Generate Username
    [Arguments]               ${protools_version}
    IF                        "${protools_version}" == "v1"
        ${prefix_name}        Prefix Male
        ${first_name}         First Name Male
        ${last_name}          Last Name Male
        Set Suite Variable    ${Random_User_Name}      ${prefix_name} ${first_name} ${last_name}
    ELSE IF                   "${protools_version}" == "v2"
        ${prefix_name}        Prefix Female
        ${first_name}         First Name Female
        ${last_name}          Last Name Female
        Set Suite Variable    ${Random_User_Name}      ${prefix_name} ${first_name} ${last_name}
    END
