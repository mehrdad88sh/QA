*** Settings ***
Documentation               Get SheypoorPlus Profile v2
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
Get SheypoorPlus Profile
    Set Log Level           TRACE
    Login Protools          v2       car-sale
    Get Profile             v2

*** Keywords ***
Get Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protoolsCars"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile
    Integer                 response status        200
    ${response}             output                 response body
    ${cellphone}            Get Value From Json    ${response}                  $.cellphone
    ${cellphone}            Convert To String      ${cellphone[0]}
    Should Be Equal         ${cellphone}           ${Random_Number}
    ${isProfileCompleted}   Get Value From Json       ${response}               $.isProfileCompleted
    ${isProfileCompleted}   Convert To String         ${isProfileCompleted[0]}
    Should Be Equal         ${isProfileCompleted}     False
    ${upgradeButton_show}   Get Value From Json       ${response}               $.upgradeButton.show
    ${upgradeButton_show}   Convert To String         ${upgradeButton_show[0]}
    Should Be Equal         ${upgradeButton_show}     False
    ${isUpgrade}            Get Value From Json       ${response}               $.upgradeButton.isUpgrade
    ${isUpgrade}            Convert To String         ${isUpgrade[0]}
    Should Be Equal         ${isUpgrade}              False
    ${auctionStatus}        Get Value From Json       ${response}                $.auctionStatus
    ${auctionStatus}        Convert To String         ${auctionStatus[0]}
    Should Be Equal         ${auctionStatus}          False
    ${nps}                  Get Value From Json       ${response}                $.nps
    ${nps}                  Convert To String         ${nps[0]}
    Should Be Equal         ${nps}                    False
