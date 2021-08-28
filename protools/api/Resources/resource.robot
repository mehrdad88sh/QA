*** Settings ***
Documentation                 Api resources
Library                       REST                            ${staging}/api/protools
Library                       JSONLibrary
Library                       String
Library                       FakerLibrary                    locale=fa_IR

*** Keywords ***
Login Protools Api
    [Arguments]               ${protools_version}             ${User_Type}
    IF                        "${User_Type}" == "real-estate"
                              Register To Alunak              ${protools_version}
                              Authentication In Protools      ${protools_version}
    ELSE IF                   "${User_Type}" == "car-sale"
                              Register To SheypoorPlus        ${protools_version}
                              Authentication In Protools      ${protools_version}
    END

Register To Alunak
    [Arguments]               ${protools_version}
    Expect Request	          {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers               {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response           ${CURDIR}/../protools.api.tests/Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                      /${protools_version}/auth/register
    ...                       {"cellphone": "${Random_User_Mobile}", "user_type": "real-estate"}
    Integer                   response status                 200
    ${response}               output                          response body
    ${token}                  Get Value From Json             ${response}              $.token
    ${token}                  Convert To String               ${token[0]}
    Set Suite Variable        ${token}                        ${token}

Register To SheypoorPlus
    [Arguments]               ${protools_version}
    Expect Request	          {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers               {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response           ${CURDIR}/../protools.api.tests/Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                      /${protools_version}/auth/register
    ...                       {"cellphone": "${Random_User_Mobile}", "user_type": "car-sale"}
    Integer                   response status                 200
    ${response}               output                          response body
    ${token}                  Get Value From Json             ${response}              $.token
    ${token}                  Convert To String               ${token[0]}
    Set Suite Variable        ${token}                        ${token}

Authentication In Protools
    [Arguments]               ${protools_version}
    Expect Request	          {"body": {"required": ["username", "password"]}}
    Set Headers               {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server Api
    Expect Response           ${CURDIR}/../protools.api.tests/Authentication/Versions/${protools_version}/schema/authenticate-by-password.json
    Post                      /${protools_version}/auth/authorize
    ...                       {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                   response status                 200
    ${response}               output                          response body
    ${access_token}           Get Value From Json             ${response}              $.access_token
    ${access_token}           Convert To String               ${access_token[0]}
    Set Test Variable         ${access_token}                 ${access_token}

Get Code From Mock Server Api
    Clear Expectations
    Get                       ${stagingMock}=${Random_User_Mobile}
    ...                       headers={"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Integer                   response status                 200
    ${response}               output                          response body
    ${Code}                   Get Value From Json             ${response}              $.code
    ${Code}                   Convert To String               ${Code[0]}
    Set Suite Variable        ${Code}                         ${Code}

Generate Random Phone Number
    ${Random_User_Mobile}     Generate Random String          7   [NUMBERS]
    Set Suite Variable        ${Random_User_Mobile}           0900${Random_User_Mobile}

Generate Random AboutMe Sentence
    ${aboutme}                Sentence                        nb_words=30
    Set Suite Variable        ${Random_AboutMe_Sentence}      ${aboutme}

Generate Username
    [Arguments]               ${protools_version}
    IF                        "${protools_version}" == "v1"
        ${prefix_name}        Prefix Male
        ${first_name}         First Name Male
        ${last_name}          Last Name Male
        Set Suite Variable    ${Random_User_Name}             ${prefix_name} ${first_name} ${last_name}
    ELSE IF                   "${protools_version}" == "v2"
        ${prefix_name}        Prefix Female
        ${first_name}         First Name Female
        ${last_name}          Last Name Female
        Set Suite Variable    ${Random_User_Name}             ${prefix_name} ${first_name} ${last_name}
    END

Check Payment In Sheypoor
    [Arguments]               ${Package_Type}
    Open Browser              ${Payment_URL}                  browser=chrome
    Wait Until Page Contains  درحال انتقال به درگاه پرداخت    timeout=10s
    Click Element             css:button.button.green
    Wait Until Page Contains  پرداخت شما با موفقیت انجام شد.  timeout=10s
    Element Should Contain    class:text-right                ${Package_Type}
    Close Browser
