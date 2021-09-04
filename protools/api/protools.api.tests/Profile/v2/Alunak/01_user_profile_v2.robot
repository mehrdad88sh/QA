*** Settings ***
Documentation               Get Alunak Profile v2
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
Get Alunak Profile
    Set Log Level           TRACE
    Login Protools Api  v2       real-estate
    Get Profile             v2

*** Keywords ***
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
    Should Be Equal         ${cellphone}              ${Random_User_Mobile}
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
