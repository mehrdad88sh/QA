*** Settings ***
Documentation              Get SheypoorPlus Profile v2
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Test Cases ***
SheypoorPlus User Profile
    Set Log Level          TRACE
    Register To SheypoorPlus        v2
    Authentication In SheypoorPlus  v2
    Get SheypoorPlus Profile               v2

*** Keywords ***
Register To SheypoorPlus
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

Authentication In SheypoorPlus
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

Get SheypoorPlus Profile
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
    ${isProfileCompleted}   Get Value From Json       ${response}                $.isProfileCompleted
    ${isProfileCompleted}   Convert To String         ${isProfileCompleted[0]}
    Should Be Equal         ${isProfileCompleted}     False
    ${upgradeButton_show}   Get Value From Json       ${response}                $.upgradeButton.show
    ${upgradeButton_show}   Convert To String         ${upgradeButton_show[0]}
    Should Be Equal         ${upgradeButton_show}     False
    ${isUpgrade}            Get Value From Json       ${response}                $.upgradeButton.isUpgrade
    ${isUpgrade}            Convert To String         ${isUpgrade[0]}
    Should Be Equal         ${isUpgrade}              False
    ${auctionStatus}        Get Value From Json       ${response}                $.auctionStatus
    ${auctionStatus}        Convert To String         ${auctionStatus[0]}
    Should Be Equal         ${auctionStatus}          False
    ${nps}                  Get Value From Json       ${response}                $.nps
    ${nps}                  Convert To String         ${nps[0]}
    Should Be Equal         ${nps}                    False
