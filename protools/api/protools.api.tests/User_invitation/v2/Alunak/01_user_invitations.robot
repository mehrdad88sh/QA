*** Settings ***
Documentation                   Sending And Showing User Invitation Alunak v2
Variables                       ../../../../Variables/Variables.py
Resource                        ../../../../Resources/resource.robot

*** Test Cases ***
Sending User Invitation
    Set Log Level           TRACE
    Login Protools Api  v2      real-estate
    Send User Invitation    v2
    Show User Invitation    v2

*** Keywords ***
Send User Invitation
    [Arguments]                 ${protools_version}
    Clear Expectations
    Set Headers                 {"X-Ticket": "${access_token}"}
    Set Headers                 {"source": "protools"}
    Generate Random Phone Number
    Post                        /${protools_version}/user-invitations
    ...                         {"cellphone": "${Random_User_Mobile}"}
    Integer                     response status                    200
    ${response}                 Output                             response body
    String                      response body message              دعوت‌‌نامه با موفقیت ارسال شد
    Post                        /${protools_version}/user-invitations
    ...                         {"cellphone": "${Random_User_Mobile}"}
    Integer                     response status                    400
    ${response}                 Output                             response body
    String                      response body error                همکار شما از قبل دعوت شده است

Show User Invitation
    [Arguments]                 ${protools_version}
    Set Headers                 {"X-Ticket": "${access_token}"}
    Set Headers                 {"source": "protools"}
    Get                         /${protools_version}/user-invitations
    Integer                     response status                    200
    ${response}                 Output                             response body
    ${item}                     Get Value From Json                ${response}            $.items[0].title
    ${item}                     Convert To String                  ${item[0]}
    Should Be Equal             ${item}                             در انتظار
    ${name}                     Get Value From Json                ${response}            $.items[0].name
    ${name}                     Convert To String                  ${name[0]}
    Should Be Equal             ${name}                            ${Random_User_Mobile}
