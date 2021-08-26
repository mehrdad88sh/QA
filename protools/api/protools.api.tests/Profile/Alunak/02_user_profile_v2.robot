*** Settings ***
Documentation              Get Alunak Profile v2 api
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Test Cases ***
Get Alunak Profile
    Set Log Level          TRACE
    Register To Alunak        v2
    Authentication In Alunak  v2
    Get Profile               v2

*** Keywords ***
Register To Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                    /${protools_version}/auth/register
    ...                     {"cellphone": "${Random_Number}", "user_type": "real-estate"}
    Integer                 response status           200
    ${response}             output                    response body
    ${token}                Get Value From Json       ${response}                $.token
    ${token}                Convert To String         ${token[0]}
    Set Test Variable       ${token}                  ${token}

Authentication In Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/authenticate-by-password.json
    Post                    /${protools_version}/auth/authorize
    ...                     {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                 response status           200
    ${response}             output                    response body
    ${access_token}         Get Value From Json       ${response}                $.access_token
    ${access_token}         Convert To String         ${access_token[0]}
    Set Test Variable       ${access_token}           ${access_token}

Get Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protools"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile
    Integer                 response status           200
    ${response}             output                    response body
    ${cellphone}            Get Value From Json       ${response}                $.cellphone
    ${cellphone}            Convert To String         ${cellphone[0]}
    Should Be Equal         ${cellphone}              ${Random_Number}
    ${isProfileCompleted}   Get Value From Json       ${response}                $.isProfileCompleted
    ${isProfileCompleted}   Convert To String         ${isProfileCompleted[0]}
    Should Be Equal         ${isProfileCompleted}     False
    ${videoCreditCount}     Get Value From Json       ${response}                $.videoCreditCount
    ${videoCreditCount}     Convert To String         ${videoCreditCount[0]}
    Should Be Equal         ${videoCreditCount}       0
    ${upgradeButton_show}   Get Value From Json       ${response}                $.upgradeButton.show
    ${upgradeButton_show}   Convert To String         ${upgradeButton_show[0]}
    Should Be Equal         ${upgradeButton_show}     True
    ${isUpgrade}            Get Value From Json       ${response}                $.upgradeButton.isUpgrade
    ${isUpgrade}            Convert To String         ${isUpgrade[0]}
    Should Be Equal         ${isUpgrade}              True
    ${upgradeButton_title}  Get Value From Json       ${response}                $.upgradeButton.title
    ${upgradeButton_title}  Convert To String         ${upgradeButton_title[0]}
    Should Be Equal         ${upgradeButton_title}    ارتقا به پروفایل حرفه‌ای
    ${nps}                  Get Value From Json       ${response}                $.nps
    ${nps}                  Convert To String         ${nps[0]}
    Should Be Equal         ${nps}                    False